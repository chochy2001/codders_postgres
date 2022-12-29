-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: public."ARTIC ULO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ARTIC ULO" CASCADE;
CREATE TABLE public."ARTIC ULO" (
	codigo_barras bigint NOT NULL,
	nombre varchar(50) NOT NULL,
	precio_compra money NOT NULL,
	precio_venta money NOT NULL,
	stock smallint NOT NULL,
	fotografia bytea NOT NULL,
	"id_categoria_CATEGORIA" integer NOT NULL,
	CONSTRAINT "ARTIC ULO_pk" PRIMARY KEY (codigo_barras)
);
-- ddl-end --
COMMENT ON COLUMN public."ARTIC ULO".stock IS E'Calculado de la cantidad por articulo';
-- ddl-end --
ALTER TABLE public."ARTIC ULO" OWNER TO postgres;
-- ddl-end --

-- object: public."CATEGORIA" | type: TABLE --
-- DROP TABLE IF EXISTS public."CATEGORIA" CASCADE;
CREATE TABLE public."CATEGORIA" (
	id_categoria integer NOT NULL,
	nombre varchar(50) NOT NULL,
	descripcion text NOT NULL,
	CONSTRAINT "CATEGORIA_pk" PRIMARY KEY (id_categoria)
);
-- ddl-end --
ALTER TABLE public."CATEGORIA" OWNER TO postgres;
-- ddl-end --

-- object: public."PROVEEDOR" | type: TABLE --
-- DROP TABLE IF EXISTS public."PROVEEDOR" CASCADE;
CREATE TABLE public."PROVEEDOR" (
	rfc varchar(13) NOT NULL,
	telefono bigint NOT NULL,
	razon_social varchar(50) NOT NULL,
	cuenta_pago bigint NOT NULL,
	numero_exterior smallint NOT NULL,
	estado varchar(40) NOT NULL,
	numero_interior smallint NOT NULL,
	codigo_postal bigint NOT NULL,
	calle varchar(50) NOT NULL,
	CONSTRAINT "PROVEEDOR_pk" PRIMARY KEY (rfc)
);
-- ddl-end --
ALTER TABLE public."PROVEEDOR" OWNER TO postgres;
-- ddl-end --

-- object: public."VENTA" | type: TABLE --
-- DROP TABLE IF EXISTS public."VENTA" CASCADE;
CREATE TABLE public."VENTA" (
	folio char(7) NOT NULL,
	fecha timestamp NOT NULL,
	monto_total money NOT NULL,
	cantidad_total smallint NOT NULL,
	"rfc_CLIENTE" varchar(13) NOT NULL,
	"id_empleado_EMPLEADO" integer NOT NULL,
	"id_empleado_EMPLEADO1" integer NOT NULL,
	CONSTRAINT "VENTA_pk" PRIMARY KEY (folio)
);
-- ddl-end --
COMMENT ON COLUMN public."VENTA".monto_total IS E'Se calcula cada que se agrega un articulo';
-- ddl-end --
COMMENT ON COLUMN public."VENTA".cantidad_total IS E'Se calcula cada que se agrega un articulo';
-- ddl-end --
ALTER TABLE public."VENTA" OWNER TO postgres;
-- ddl-end --

-- object: public."CLIENTE" | type: TABLE --
-- DROP TABLE IF EXISTS public."CLIENTE" CASCADE;
CREATE TABLE public."CLIENTE" (
	rfc varchar(13) NOT NULL,
	email varchar(100) NOT NULL,
	nombre varchar(60) NOT NULL,
	apellido_paterno varchar(40) NOT NULL,
	apellido_materno varchar(40),
	codigo_postal bigint NOT NULL,
	calle varchar(50) NOT NULL,
	numero_interior smallint NOT NULL,
	numero_exterior smallint NOT NULL,
	estado varchar(50) NOT NULL,
	razon_social varchar(50) NOT NULL,
	CONSTRAINT "CLIENTE_pk" PRIMARY KEY (rfc)
);
-- ddl-end --
COMMENT ON COLUMN public."CLIENTE".razon_social IS E'Unique';
-- ddl-end --
ALTER TABLE public."CLIENTE" OWNER TO postgres;
-- ddl-end --

-- object: public."EMPLEADO" | type: TABLE --
-- DROP TABLE IF EXISTS public."EMPLEADO" CASCADE;
CREATE TABLE public."EMPLEADO" (
	id_empleado integer NOT NULL,
	curp char(18) NOT NULL,
	rfc char(13) NOT NULL,
	nombre varchar(60) NOT NULL,
	apellido_paterno varchar(40) NOT NULL,
	apellido_materno varchar(40),
	fecha_ingreso date NOT NULL,
	tipo char(1) NOT NULL,
	email varchar(100) NOT NULL,
	numero_exterior smallint NOT NULL,
	numero_interior smallint NOT NULL,
	estado varchar(50) NOT NULL,
	codigo_postal bigint NOT NULL,
	calle varchar(50) NOT NULL,
	"id_sucursal_SUCURSAL" integer NOT NULL,
	"id_empleado_EMPLEADO" integer NOT NULL,
	CONSTRAINT "EMPLEADO_pk" PRIMARY KEY (id_empleado)
);
-- ddl-end --
ALTER TABLE public."EMPLEADO" OWNER TO postgres;
-- ddl-end --

-- object: public."TELEFONO" | type: TABLE --
-- DROP TABLE IF EXISTS public."TELEFONO" CASCADE;
CREATE TABLE public."TELEFONO" (
	telefono_empleado bigint NOT NULL,
	"id_empleado_EMPLEADO" integer NOT NULL,
	CONSTRAINT "TELEFONO_pk" PRIMARY KEY (telefono_empleado)
);
-- ddl-end --
ALTER TABLE public."TELEFONO" OWNER TO postgres;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."TELEFONO" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."TELEFONO" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("id_empleado_EMPLEADO")
REFERENCES public."EMPLEADO" (id_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."SUCURSAL" | type: TABLE --
-- DROP TABLE IF EXISTS public."SUCURSAL" CASCADE;
CREATE TABLE public."SUCURSAL" (
	id_sucursal integer NOT NULL,
	anio_fundacion date NOT NULL,
	telefono bigint NOT NULL,
	numero_exterior smallint NOT NULL,
	numero_interior smallint NOT NULL,
	estado varchar(50) NOT NULL,
	codigo_postal bigint NOT NULL,
	calle varchar(50) NOT NULL,
	CONSTRAINT "SUCURSAL_pk" PRIMARY KEY (id_sucursal)
);
-- ddl-end --
ALTER TABLE public."SUCURSAL" OWNER TO postgres;
-- ddl-end --

-- object: public."many_PROVEEDOR_has_many_ARTIC ULO" | type: TABLE --
-- DROP TABLE IF EXISTS public."many_PROVEEDOR_has_many_ARTIC ULO" CASCADE;
CREATE TABLE public."many_PROVEEDOR_has_many_ARTIC ULO" (
	"rfc_PROVEEDOR" varchar(13) NOT NULL,
	"codigo_barras_ARTIC ULO" bigint NOT NULL,
	fecha_comienzo date NOT NULL,
	CONSTRAINT "many_PROVEEDOR_has_many_ARTIC ULO_pk" PRIMARY KEY ("rfc_PROVEEDOR","codigo_barras_ARTIC ULO")
);
-- ddl-end --

-- object: "PROVEEDOR_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_PROVEEDOR_has_many_ARTIC ULO" DROP CONSTRAINT IF EXISTS "PROVEEDOR_fk" CASCADE;
ALTER TABLE public."many_PROVEEDOR_has_many_ARTIC ULO" ADD CONSTRAINT "PROVEEDOR_fk" FOREIGN KEY ("rfc_PROVEEDOR")
REFERENCES public."PROVEEDOR" (rfc) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "ARTIC ULO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_PROVEEDOR_has_many_ARTIC ULO" DROP CONSTRAINT IF EXISTS "ARTIC ULO_fk" CASCADE;
ALTER TABLE public."many_PROVEEDOR_has_many_ARTIC ULO" ADD CONSTRAINT "ARTIC ULO_fk" FOREIGN KEY ("codigo_barras_ARTIC ULO")
REFERENCES public."ARTIC ULO" (codigo_barras) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "CATEGORIA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."ARTIC ULO" DROP CONSTRAINT IF EXISTS "CATEGORIA_fk" CASCADE;
ALTER TABLE public."ARTIC ULO" ADD CONSTRAINT "CATEGORIA_fk" FOREIGN KEY ("id_categoria_CATEGORIA")
REFERENCES public."CATEGORIA" (id_categoria) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."many_VENTA_has_many_ARTIC ULO" | type: TABLE --
-- DROP TABLE IF EXISTS public."many_VENTA_has_many_ARTIC ULO" CASCADE;
CREATE TABLE public."many_VENTA_has_many_ARTIC ULO" (
	"folio_VENTA" char(7) NOT NULL,
	"codigo_barras_ARTIC ULO" bigint NOT NULL,
	monto money NOT NULL,
	cantidad smallint NOT NULL,
	CONSTRAINT "many_VENTA_has_many_ARTIC ULO_pk" PRIMARY KEY ("folio_VENTA","codigo_barras_ARTIC ULO")
);
-- ddl-end --

-- object: "VENTA_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_VENTA_has_many_ARTIC ULO" DROP CONSTRAINT IF EXISTS "VENTA_fk" CASCADE;
ALTER TABLE public."many_VENTA_has_many_ARTIC ULO" ADD CONSTRAINT "VENTA_fk" FOREIGN KEY ("folio_VENTA")
REFERENCES public."VENTA" (folio) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "ARTIC ULO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_VENTA_has_many_ARTIC ULO" DROP CONSTRAINT IF EXISTS "ARTIC ULO_fk" CASCADE;
ALTER TABLE public."many_VENTA_has_many_ARTIC ULO" ADD CONSTRAINT "ARTIC ULO_fk" FOREIGN KEY ("codigo_barras_ARTIC ULO")
REFERENCES public."ARTIC ULO" (codigo_barras) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "CLIENTE_fk" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "CLIENTE_fk" CASCADE;
ALTER TABLE public."VENTA" ADD CONSTRAINT "CLIENTE_fk" FOREIGN KEY ("rfc_CLIENTE")
REFERENCES public."CLIENTE" (rfc) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."VENTA" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("id_empleado_EMPLEADO")
REFERENCES public."EMPLEADO" (id_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "EMPLEADO_fk1" | type: CONSTRAINT --
-- ALTER TABLE public."VENTA" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk1" CASCADE;
ALTER TABLE public."VENTA" ADD CONSTRAINT "EMPLEADO_fk1" FOREIGN KEY ("id_empleado_EMPLEADO1")
REFERENCES public."EMPLEADO" (id_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "SUCURSAL_fk" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "SUCURSAL_fk" CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT "SUCURSAL_fk" FOREIGN KEY ("id_sucursal_SUCURSAL")
REFERENCES public."SUCURSAL" (id_sucursal) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "EMPLEADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."EMPLEADO" DROP CONSTRAINT IF EXISTS "EMPLEADO_fk" CASCADE;
ALTER TABLE public."EMPLEADO" ADD CONSTRAINT "EMPLEADO_fk" FOREIGN KEY ("id_empleado_EMPLEADO")
REFERENCES public."EMPLEADO" (id_empleado) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


