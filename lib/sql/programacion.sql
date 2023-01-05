--Trigger para validar que en la VENTA los empleados (Vendedor y Cajero) pertenecen a la misma sucursal
CREATE OR REPLACE function emple_sucur() RETURNS TRIGGER AS $emple_sucur$
DECLARE suc1 integer;
DECLARE suc2 integer;

BEGIN
	SELECT DISTINCT s.id_sucursal INTO suc1 FROM VENTA as v1 
	LEFT JOIN EMPLEADO AS e ON new.id_empleado=e.id_empleado 
	LEFT JOIN SUCURSAL AS s ON s.id_sucursal=e.id_sucursal;

	SELECT DISTINCT s.id_sucursal INTO suc2 FROM VENTA as v2
	LEFT JOIN EMPLEADO AS e ON new.id_empleado1=e.id_empleado 
	LEFT JOIN SUCURSAL AS s ON s.id_sucursal=e.id_sucursal;

	IF 	(suc1!=suc2) THEN
		RAISE NOTICE 'Los empleados pertenecen a sucursales diferentes';
		RETURN NULL;
	END IF;
		RETURN NEW;
END;
$emple_sucur$ LANGUAGE PLPGSQL;


CREATE TRIGGER emple_sucur BEFORE INSERT OR UPDATE ON venta
FOR EACH ROW EXECUTE FUNCTION emple_sucur();


--Trigger para agregar por defecto el nombre completo en CLIENTE para razón social
CREATE OR REPLACE function razonS_Default() RETURNS TRIGGER AS $razonS_Default$
BEGIN
	IF 	(new.razon_social is NULL) THEN
		update cliente set razon_social=CONCAT(new.nombre,' ',new.apellido_paterno,' ',new.apellido_materno) WHERE rfc=new.rfc;
	END IF;
		RETURN NEW;
END;
$razonS_Default$ LANGUAGE PLPGSQL;


CREATE TRIGGER razonS_Default AFTER INSERT OR UPDATE ON cliente
FOR EACH ROW EXECUTE FUNCTION razonS_Default();


--Trigger para calcular el valor del monto por articulo en ES_VENDIDO
CREATE OR REPLACE function montoXArt() RETURNS TRIGGER AS $montoXArt$
DECLARE montoTot numeric(8,2);
DECLARE totalArti smallint;
DECLARE totalCosto numeric;
BEGIN

	SELECT precio_venta INTO montoTot FROM articulo AS ar WHERE ar.codigo_barras=new.codigo_barras;
	IF(montoTot IS NULL) THEN
		SELECT precio_venta INTO montoTot FROM low_stock AS lw WHERE lw.codigo_barras=new.codigo_barras;
	END IF;
	IF	(TG_OP='INSERT') THEN
		update es_vendido set monto=(montoTot*new.cantidad)  WHERE codigo_barras=new.codigo_barras AND folio=new.folio;

		--Parte que realiza el cálculo del monto total y de la cantidad total
		IF(new.finish) THEN
			SELECT SUM(cantidad) INTO totalArti FROM es_vendido GROUP BY folio HAVING folio=new.folio;
			SELECT SUM(monto) INTO totalCosto FROM es_vendido GROUP BY folio HAVING folio=new.folio;

			UPDATE venta SET monto_total=totalCosto, cantidad_total=totalArti WHERE folio=new.folio;
			--Agregar ticket
		END IF;
	END IF;

	RETURN NEW;
END;
$montoXArt$ LANGUAGE PLPGSQL;


CREATE TRIGGER montoXArt AFTER INSERT OR UPDATE ON ES_VENDIDO
FOR EACH ROW EXECUTE FUNCTION montoXArt();

--Trigger para generar el formato del ID de la VENTA (MBL-XXX)
CREATE OR REPLACE FUNCTION venta_formato() RETURNS TRIGGER AS $$
DECLARE valAct smallint;
BEGIN
	valAct=CAST(new.folio AS smallint);
	IF(valAct<10) THEN
		UPDATE venta set folio=CONCAT('MBL-00',valAct) where folio=NEW.folio;
	ELSEIF(valAct<100) THEN
		UPDATE venta set folio=CONCAT('MBL-0',valAct) where folio=NEW.folio;
	ELSEIF(valAct<1000) THEN
		UPDATE venta set folio=CONCAT('MBL-',valAct) where folio=NEW.folio;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER venta_formato AFTER INSERT ON venta
FOR EACH ROW EXECUTE FUNCTION venta_formato();

CREATE SEQUENCE secue_folio_venta AS smallint
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 999
	START 1
	NO CYCLE
	OWNED BY VENTA.folio;

CREATE TABLE public.low_stock(
	codigo_barras bigint NOT NULL,
	nombre varchar(50) NOT NULL,
	precio_compra numeric(8,2) NOT NULL,
	precio_venta numeric(8,2) NOT NULL,
	stock smallint NOT NULL,
	fotografia text NOT NULL,
	"id_categoria" integer NOT NULL,
	CONSTRAINT "LOW_STOCK_pk" PRIMARY KEY (codigo_barras)
);
CREATE TABLE public.low_stock_provee (
	"rfc" varchar(13) NOT NULL,
	"codigo_barras" bigint NOT NULL,
	fecha_comienzo date NOT NULL,
	CONSTRAINT "low_stock_provee_pk" PRIMARY KEY ("rfc","codigo_barras")
);

-- Trigger para crear una tabla auxiliar para productos con stock menor a 3
CREATE OR REPLACE FUNCTION eliminacion_2() RETURNS TRIGGER AS $$
DECLARE cantidad smallint;
	BEGIN
		SELECT COUNT(*) INTO cantidad FROM articulo where stock<3;
		IF(cantidad!=0) THEN

			INSERT INTO low_stock SELECT * FROM articulo AS ar WHERE ar.stock<3;
			INSERT INTO low_stock_provee SELECT pr.rfc,pr.codigo_barras,pr.fecha_comienzo FROM provee AS pr 
				LEFT JOIN articulo ar ON pr.codigo_barras=ar.codigo_barras WHERE ar.stock<3 ;

			DELETE FROM provee pr WHERE rfc=(select pr.rfc from provee pr LEFT JOIN articulo ar ON pr.codigo_barras=ar.codigo_barras WHERE ar.stock<3) 
				AND codigo_barras=(select pr.codigo_barras from provee pr LEFT JOIN articulo ar ON pr.codigo_barras=ar.codigo_barras WHERE ar.stock<3);
			DELETE FROM articulo WHERE stock<3;
			RAISE NOTICE 'El articulo ya no esta disponible';
		END IF;
		RETURN NEW;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminacion_2 AFTER INSERT OR UPDATE OR DELETE ON articulo FOR EACH ROW EXECUTE PROCEDURE eliminacion_2();


-- Tigger pare retornar productos desde tabla auxiliar a tabla de artículos para productos con stock mayor a 3
CREATE OR REPLACE FUNCTION agregacion_2() RETURNS TRIGGER AS $$
DECLARE amount smallint;
	BEGIN
		SELECT COUNT(*) INTO amount FROM low_stock where stock>3;
		IF(amount!=0) THEN
			INSERT INTO articulo SELECT * FROM low_stock AS lw WHERE lw.stock>3;
			INSERT INTO provee SELECT pr.rfc,pr.codigo_barras,pr.fecha_comienzo FROM low_stock_provee AS pr 
				LEFT JOIN articulo ar ON pr.codigo_barras=ar.codigo_barras WHERE ar.stock>3;

			DELETE FROM low_stock_provee pr WHERE rfc=(select pr.rfc from provee pr LEFT JOIN articulo ar ON pr.codigo_barras=ar.codigo_barras WHERE ar.stock>3)
				AND codigo_barras=(select pr.codigo_barras from provee pr LEFT JOIN articulo ar ON pr.codigo_barras=ar.codigo_barras WHERE ar.stock>3);
			DELETE FROM low_stock WHERE stock>3;
			RAISE NOTICE 'El articulo esta disponible';
		END IF;
		RETURN NEW;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER agregacion_2 AFTER INSERT OR UPDATE OR DELETE ON low_stock FOR EACH ROW EXECUTE PROCEDURE agregacion_2();

CREATE VIEW vis_articulos_cat_prov AS
	select a.nombre,a.precio_venta,a.fotografia,c.nombre categoria,c.descripcion,p.razon_social empresa FROM articulo a
	LEFT JOIN categoria c ON a.id_categoria=c.id_categoria
	LEFT JOIN provee pe ON a.codigo_barras=pe.codigo_barras
	LEFT JOIN proveedor p ON p.rfc=pe.rfc;


--Trigger que actualiza los valores en stock de los articulos
CREATE OR REPLACE function restador_stock() RETURNS TRIGGER AS $restador_stock$
DECLARE stockArt smallint;
BEGIN
	SELECT stock INTO stockArt FROM articulo where codigo_barras=new.codigo_barras;
	IF(stockArt<=new.cantidad) THEN
		RAISE NOTICE 'La cantidad de articulos en el carrito supera el stock disponible';
		RETURN NULL;
	END IF;

	UPDATE articulo SET stock=(stockArt-new.cantidad) where codigo_barras=new.codigo_barras;

	RETURN NEW;
END;
$restador_stock$ LANGUAGE PLPGSQL;

CREATE TRIGGER restador_stock BEFORE INSERT ON es_vendido
FOR EACH ROW EXECUTE FUNCTION restador_stock();


