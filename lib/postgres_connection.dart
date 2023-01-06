import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

var connection = PostgreSQLConnection(
  "ec2-3-230-122-20.compute-1.amazonaws.com",
  5432,
  "d47n7tat72jgb5",
  username: "mdthlconjlitvq",
  password: "21aafc74c29a1d117e928bbcceabe5eb4ce242b0823e6bd139ddad54622046df",
  timeoutInSeconds: 300,
  queryTimeoutInSeconds: 300,
  allowClearTextPassword: false,
  useSSL: true,
);
List<List<dynamic>> resultsArticulos = [];
List<List<dynamic>> resultsCategorias = [];
List<List<dynamic>> resultsClientes = [];
List<List<dynamic>> resultsEmpleados = [];
List<List<dynamic>> resultsProveedores = [];
List<List<dynamic>> resultsSucursales = [];
List<List<dynamic>> resultsTelefono = [];
List<List<dynamic>> resultsVentas = [];
List<List<dynamic>> resultsFotografias = [];

class PostgresConnection {
  Future connect() async {
    try {
      await connection.open();
      if (kDebugMode) {
        print("Connected to PostgreSQL");
      }
    } catch (e) {
      if (kDebugMode) {
        print('error');
        print(e.toString());
      }
    }
  }

  Future disconnect() async {
    try {
      await connection.close();
      if (kDebugMode) {
        print("Disconnected to PostgreSQL");
      }
    } catch (e) {
      if (kDebugMode) {
        print('error');
        print(e.toString());
      }
    }
  }

  selectImageArticles() async {
    try {
      //todo cambiar a que sean todos los valores
      resultsFotografias = await connection
          .query("select fotografia from articulo where codigo_barras = 12344");
      debugPrint("seleccion de fotografias");

      for (final row in resultsFotografias) {
        if (kDebugMode) {
          print(row);
        }
      }
      return resultsFotografias;
    } catch (e) {
      if (kDebugMode) {
        print('error');
        print(e.toString());
      }
    }
  }

  selectAllArticles() async {
    try {
      resultsArticulos = await connection.query(
          "Select nombre,precio_venta,categoria,descripcion,empresa from vis_articulos_cat_prov");
      debugPrint("seleccion de todos los articulos");

      return resultsArticulos;
    } catch (e) {
      if (kDebugMode) {
        print('error');
        print(e.toString());
      }
    }
  }

  selectAllCategories() async {
    try {
      resultsCategorias = await connection.query("Select * from categoria");
      debugPrint("seleccion de todas las categorias");

      for (final row in resultsCategorias) {
        if (kDebugMode) {
          print(row);
        }
      }
      return resultsCategorias;
    } catch (e) {
      if (kDebugMode) {
        print('error');
        print(e.toString());
      }
    }
  }

  selectAllCustomers() async {
    try {
      resultsClientes = await connection.query("Select * from cliente ");
      debugPrint("seleccion de todos los clientes");

      for (final row in resultsClientes) {
        if (kDebugMode) {
          print(row);
        }
      }
      return resultsClientes;
    } catch (e) {
      if (kDebugMode) {
        print('error');
        print(e.toString());
      }
    }
  }

  selectAllEmployees() async {
    try {
      resultsEmpleados = await connection.query("Select * from empleado");
      debugPrint("seleccion de todas los empleados");

      for (final row in resultsEmpleados) {
        if (kDebugMode) {
          print(row);
        }
      }
      return resultsEmpleados;
    } catch (e) {
      if (kDebugMode) {
        print('error');
        print(e.toString());
      }
    }
  }

  selectAllProviders() async {
    try {
      resultsProveedores = await connection.query("Select * from proveedor");
      debugPrint("seleccion de todas las sucursales");

      for (final row in resultsProveedores) {
        if (kDebugMode) {
          print(row);
        }
      }
      return resultsProveedores;
    } catch (e) {
      if (kDebugMode) {
        print('error');
        print(e.toString());
      }
    }
  }

  selectAllBranches() async {
    try {
      resultsSucursales = await connection.query("Select * from sucursal");
      debugPrint("seleccion de todas las sucursales");

      for (final row in resultsSucursales) {
        if (kDebugMode) {
          print(row);
        }
      }
      return resultsSucursales;
    } catch (e) {
      if (kDebugMode) {
        print('error');
        print(e.toString());
      }
    }
  }

  selectAllTelephones() async {
    try {
      resultsTelefono = await connection.query("Select * from telefono");
      debugPrint("seleccion de todos los telefonos");

      for (final row in resultsTelefono) {
        if (kDebugMode) {
          print(row);
        }
      }
      return resultsTelefono;
    } catch (e) {
      if (kDebugMode) {
        print('error');
        print(e.toString());
      }
    }
  }

  selectAllSales() async {
    try {
      resultsVentas = await connection.query("Select * from venta");
      debugPrint("seleccion de todas las ventas");

      //Imprime todos los valores de la tabla
      //todo
      for (int i = 0; i < resultsVentas.length; i++) {
        for (int j = 0; j < resultsVentas[i].length; j++) {
          debugPrint(resultsVentas[i][j].toString());
          //resultsVentas[i][j] = resultsVentas[i][j];
        }
      }
      return resultsVentas;
    } catch (e) {
      if (kDebugMode) {
        print('error');
        print(e.toString());
      }
    }
  }
}
