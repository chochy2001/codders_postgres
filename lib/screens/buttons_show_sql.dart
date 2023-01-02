import 'package:flutter/material.dart';
import 'package:codders_postgres/postgres_connection.dart';

class ButtonsShowSql extends StatelessWidget {
  const ButtonsShowSql({super.key});

  @override
  Widget build(BuildContext context) {
    //Conectandonos a la base de datos
    PostgresConnection postgresConnection = PostgresConnection();
    postgresConnection.connect();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Muebleria Codders'),
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
                        child: const Text('Mostrar todos los Articulos'),
                      ),
                      TextButton(
                        onPressed: () {
                          postgresConnection.selectAllCategories();
                        },
                        child: const Text('Mostrar todas las Categorias '),
                      ),
                      TextButton(
                        onPressed: () {
                          postgresConnection.selectAllCustomers();
                        },
                        child: const Text('Mostrar todos los Clientes'),
                      ),
                      TextButton(
                        onPressed: () {
                          postgresConnection.selectAllEmployees();
                        },
                        child: const Text('Mostrar todos los Empleados'),
                      ),
                      TextButton(
                        onPressed: () {
                          postgresConnection.selectAllProviders();
                        },
                        child: const Text('Mostrar todos los Proveedores'),
                      ),
                      TextButton(
                        onPressed: () {
                          postgresConnection.selectAllBranches();
                        },
                        child: const Text('Mostrar todas las Sucursales'),
                      ),
                      TextButton(
                        onPressed: () {
                          postgresConnection.selectAllTelephones();
                        },
                        child: const Text('Mostrar todos los Teléfonos'),
                      ),
                      TextButton(
                        onPressed: () {
                          postgresConnection.selectAllSales();
                        },
                        child: const Text('Mostrar todas las Ventas'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                          postgresConnection.selectAllEmployees();
                        },
                        child: const Text('Agregar Empleado'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
