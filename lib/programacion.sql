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