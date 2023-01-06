-- Creamos un índice en artículo porque es la información que más se consulta
create index ix_articulo on articulo(
  codigo_barras,
  nombre,
  precio_compra,
  precio_venta,
  stock,
  id_categoria
);