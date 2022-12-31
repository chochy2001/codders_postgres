import 'package:codders_postgres/postgres_connection.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Conectandonos a la base de datos
    PostgresConnection postgresConnection = PostgresConnection();
    postgresConnection.connect();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Muebleria Codders',
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Muebleria Codders Postgres',
              ),
            ),
          ),
          body: Center(
            child: ListView(
              //centrar listview

              scrollDirection: Axis.vertical,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'App de uso de Postgres para obtener información\n',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: ButtonBar(
                        mainAxisSize: MainAxisSize.min,
                        alignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              postgresConnection.selectAllArticles();
                            },
                            child: const Text('Mostrar todos los articulos'),
                          ),
                          TextButton(
                            onPressed: () {
                              postgresConnection.selectAllCustomers();
                            },
                            child: const Text('Mostrar todos los clientes'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
