import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:codders_postgres/postgres_connection.dart';

class ButtonsShowSql extends StatefulWidget {
  const ButtonsShowSql({super.key});

  @override
  State<ButtonsShowSql> createState() => _ButtonsShowSqlState();
}

class _ButtonsShowSqlState extends State<ButtonsShowSql> {
  //late List<Map<String, Map<String, dynamic>>> listaArticulos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isVisible = true;
  String textoBoton = "Mostrar";

  PostgresConnection postgresConnection = PostgresConnection();

  @override
  Widget build(BuildContext context) {
    //Conectandonos a la base de datos
    postgresConnection.connect();

    postgresConnection.selectImageArticles();
    Timer(const Duration(seconds: 4), () {
      debugPrint(resultsFotografias.first.toString());
    });

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
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                            if (isVisible) {
                              textoBoton = "Mostrar Todo";
                            } else {
                              textoBoton = "Ocultar Todo";
                            }
                          });
                        },
                        child: Text(textoBoton),
                      ),
                      /*
                      Image.memory(
                        const Base64Decoder()
                            .convert(resultsFotografias.first.toString()),
                        width: 200.0,
                        height: 170.0,
                      ),
                      Image.memory(
                        base64Decode(postgresConnection
                            .selectImageArticles()
                            .toString()),
                        //base64Decode(resultsFotografias.first.toString()),
                        width: 200.0,
                        height: 170.0,
                      ),
                       */
                      Image.asset('lib/svg/imgMuebleria/bar.jpg'),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            postgresConnection.selectAllArticles();
                            debugPrint(resultsArticulos.toString());
                          });
                        },
                        child: const Text('Mostrar todos los Articulos'),
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Text(
                          mostrarDatos(resultsArticulos),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            postgresConnection.selectAllCategories();
                            debugPrint(resultsCategorias.toString());
                          });
                        },
                        child: const Text('Mostrar todas las Categorias '),
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Text(
                          mostrarDatos(resultsCategorias),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            postgresConnection.selectAllCustomers();
                            debugPrint(resultsCategorias.toString());
                          });
                        },
                        child: const Text('Mostrar todos los Clientes'),
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Text(
                          mostrarDatos(resultsClientes),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            postgresConnection.selectAllEmployees();
                            debugPrint(resultsEmpleados.toString());
                          });
                        },
                        child: const Text('Mostrar todos los Empleados'),
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Text(
                          mostrarDatos(resultsEmpleados),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            postgresConnection.selectAllProviders();
                            debugPrint(resultsProveedores.toString());
                          });
                        },
                        child: const Text('Mostrar todos los Proveedores'),
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Text(
                          mostrarDatos(resultsProveedores),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            postgresConnection.selectAllBranches();
                            debugPrint(resultsSucursales.toString());
                          });
                        },
                        child: const Text('Mostrar todas las Sucursales'),
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Text(
                          mostrarDatos(resultsSucursales),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            postgresConnection.selectAllTelephones();
                            debugPrint(resultsTelefono.toString());
                          });
                        },
                        child: const Text('Mostrar todos los Teléfonos'),
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Text(
                          mostrarDatos(resultsTelefono),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            postgresConnection.selectAllSales();
                            debugPrint(resultsVentas.toString());
                          });
                        },
                        child: const Text('Mostrar todas las Ventas'),
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Text(
                          resultsVentas.toString(),
                        ),
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

  mostrarDatos(results) {
    final List<List<dynamic>> resultados = [];

    for (final row in results) {
      resultados.add(row);
    }
    return resultados.toString();
  }
}
