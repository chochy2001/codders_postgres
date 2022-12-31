import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

class PostgresConnection {
  var connection = PostgreSQLConnection(
    "ec2-3-230-122-20.compute-1.amazonaws.com",
    5432,
    "d47n7tat72jgb5",
    username: "mdthlconjlitvq",
    password:
        "21aafc74c29a1d117e928bbcceabe5eb4ce242b0823e6bd139ddad54622046df",
    timeoutInSeconds: 300,
    queryTimeoutInSeconds: 300,
    allowClearTextPassword: false,
    useSSL: true,
  );

  Future connect() async {
    try {
      await connection.open();
      print("Connected to PostgreSQL");
    } catch (e) {
      print('error');
      print(e.toString());
    }
  }

  Future selectAllArticles() async {
    List<List<dynamic>> results =
        await connection.query("Select * from articulo");
    debugPrint("seleccion de todos los articulos");

    for (final row in results) {
      if (kDebugMode) {
        print(row);
      }
    }
  }

  Future selectAllCategories() async {
    List<List<dynamic>> results =
        await connection.query("Select * from categoria");
    debugPrint("seleccion de todos las categorias");

    for (final row in results) {
      if (kDebugMode) {
        print(row);
      }
    }
  }

  Future selectAllCustomers() async {
    List<List<dynamic>> results =
        await connection.query("Select * from cliente");
    debugPrint("seleccion de todos los clientes");

    for (final row in results) {
      if (kDebugMode) {
        print(row);
      }
    }
  }

  Future selectAllEmployees() async {
    List<List<dynamic>> results =
        await connection.query("Select * from empleado");
    debugPrint("seleccion de todos los empleados");

    for (final row in results) {
      if (kDebugMode) {
        print(row);
      }
    }
  }

  Future selectAllProviders() async {
    List<List<dynamic>> results =
        await connection.query("Select * from proveedor");
    debugPrint("seleccion de todos los proveedores");

    for (final row in results) {
      if (kDebugMode) {
        print(row);
      }
    }
  }

  Future selectAllBranches() async {
    List<List<dynamic>> results =
        await connection.query("Select * from sucursal");
    debugPrint("seleccion de todas las sucursales");

    for (final row in results) {
      if (kDebugMode) {
        print(row);
      }
    }
  }

  Future selectAllTelephones() async {
    List<List<dynamic>> results =
        await connection.query("Select * from telefono");
    debugPrint("seleccion de todos los tel");

    for (final row in results) {
      if (kDebugMode) {
        print(row);
      }
    }
  }
}

/*Future connectionPostgres() async {
  var connection = PostgreSQLConnection(
    "ec2-3-230-122-20.compute-1.amazonaws.com",
    5432,
    "d47n7tat72jgb5",
    username: "mdthlconjlitvq",
    password:
        "21aafc74c29a1d117e928bbcceabe5eb4ce242b0823e6bd139ddad54622046df",
    timeoutInSeconds: 300,
    queryTimeoutInSeconds: 300,
    allowClearTextPassword: false,
    useSSL: true,
  );
  try {
    await connection.open();
    print("Connected to PostgreSQL");
  } catch (e) {
    print('error');
    print(e.toString());
  }

  List<List<dynamic>> results =
      await connection.query("Select * from articulo");
  debugPrint("seleccion de todos los articulos");

  for (final row in results) {
    if (kDebugMode) {
      print(row);
    }
  }
}

selectAllArticles() async {

  List<List<dynamic>> results =
  await connection.query("Select * from articulo");
  debugPrint("seleccion de todos los articulos");

  for (final row in results) {
    if (kDebugMode) {
      print(row);
    }
  }

}
 */
