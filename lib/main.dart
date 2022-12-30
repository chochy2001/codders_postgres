import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> selectArticulos() async {
    var connection = PostgreSQLConnection(
      "ec2-3-230-122-20.compute-1.amazonaws.com",
      5432,
      "d47n7tat72jgb5",
      username: "mdthlconjlitvq",
      password:
          "21aafc74c29a1d117e928bbcceabe5eb4ce242b0823e6bd139ddad54622046df",
    );
    await connection.open();

    List<List<dynamic>> results =
        await connection.query("Select * from articulo");
    debugPrint("Hola mundo");

    for (final row in results) {
      if (kDebugMode) {
        print(row);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Muebleria Codders Postgres',
            ),
          ),
        ),
        body: const Center(
          child: Text(
            'App de uso de Postgres para obtener información\n ME ENCANTAS AMOR',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
