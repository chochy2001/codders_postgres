import 'dart:async';
import 'dart:convert';

import 'package:codders_postgres/postgres_connection.dart';
import 'package:flutter/material.dart';

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

  bool isVisibleImagenesArticulos = false;
  bool isVisibleInfoArticulos = false;
  bool isVisibleCategorias = false;
  bool isVisibleClientes = false;
  bool isVisibleEmpleados = false;
  bool isVisibleProveedores = false;
  bool isVisibleSucursales = false;
  bool isVisibleTelefonos = false;
  bool isVisibleVentas = false;
  String textoBoton = "Mostrar Todo";
  String textoBoton2 = "Ocultar Todo";
  String textoBotonGenerico = "Mostrar";
  String base64Image = '';
  String textoImagen = '';
  String imageBueno =
      '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';

  PostgresConnection postgresConnection = PostgresConnection();

  @override
  Widget build(BuildContext context) {
    //Conectandonos a la base de datos
    postgresConnection.connect();

    postgresConnection.selectAllArticles();

    Timer(const Duration(seconds: 4), () {
      MiWidget(resultsWidget: resultsArticulos).recorrerLista(resultsArticulos);
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'App de uso de Postgres para obtener información\n',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: ButtonBar(
                    buttonHeight: 50,
                    //buttonTextTheme: ButtonTextTheme.accent,
                    mainAxisSize: MainAxisSize.min,
                    alignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                isVisibleImagenesArticulos = true;
                                isVisibleInfoArticulos = true;
                                isVisibleCategorias = true;
                                isVisibleClientes = true;
                                isVisibleEmpleados = true;
                                isVisibleProveedores = true;
                                isVisibleSucursales = true;
                                isVisibleTelefonos = true;
                                isVisibleVentas = true;

                                textoBoton = "Mostrar Todo";
                              });
                            },
                            elevation: 5,
                            color: Colors.grey[300],
                            height: 40,
                            child: Text(textoBoton),
                          ),
                          kSizedBox(),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                isVisibleImagenesArticulos = false;
                                isVisibleInfoArticulos = false;
                                isVisibleCategorias = false;
                                isVisibleClientes = false;
                                isVisibleEmpleados = false;
                                isVisibleProveedores = false;
                                isVisibleSucursales = false;
                                isVisibleTelefonos = false;
                                isVisibleVentas = false;

                                textoBoton2 = "Ocultar Todo";
                              });
                            },
                            elevation: 5,
                            color: Colors.grey[300],
                            height: 40,
                            child: Text(textoBoton2),
                          ),
                        ],
                      ),
                      //imagenesArticulos
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                postgresConnection.selectImageArticles();
                                textoImagen =
                                    changeValue(resultsFotografias.toString());
                                debugPrint(textoImagen);
                              });
                            },
                            child: const Text('Solicitar imagen Articulos'),
                          ),
                          kSizedBox(),
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                isVisibleImagenesArticulos =
                                    !isVisibleImagenesArticulos;
                              });
                            },
                            child: const Text('Mostrar/Ocultar'),
                          ),
                        ],
                      ),
                      //ImagenesArticulos
                      Visibility(
                        visible: isVisibleImagenesArticulos,
                        child: Column(
                          children: [
                            Image.asset('lib/svg/ImgMuebleria/bar.jpg'),
                            kSizedBox(),
                            const Text(
                                'CONJUNTO DE DORMITORIO\n\$42100\ncristal\nmuebles de cristal\nMaderas SA\n'),
                            kSizedBox(),
                            Image.asset('lib/svg/ImgMuebleria/buro.jpg'),
                            const Text(
                                'COMEDOR RUSTICO\n\$21875\nmadera\nmuebles de madera\n\n'),
                            kSizedBox(),
                            Image.asset('lib/svg/ImgMuebleria/cajonera.jpg'),
                            const Text(
                                'CAJONERA COCINA\n\$18475\nbambú\nmuebles de bambú\n\n'),
                            kSizedBox(),
                            Image.asset('lib/svg/ImgMuebleria/centro_j.jpg'),
                            const Text(
                                'CENTRO DE JUEGO\n\$15500\nmetal\nmuebles de metal\n\n'),
                            kSizedBox(),
                            Image.asset('lib/svg/ImgMuebleria/sofa_ca.jpg'),
                            const Text(
                                'SOFA CAMA\n\$15000\nratán\nmuebles de ratán\n\n'),
                            kSizedBox(),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isVisibleImagenesArticulos,
                        child: Image.memory(
                          imageMemoryReady(textoImagen),
                        ),
                      ),
                      //infoArticulos
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                postgresConnection.selectAllArticles();
                                debugPrint(resultsArticulos.toString());
                              });
                            },
                            child: const Text('Solicitar Info Articulos'),
                          ),
                          kSizedBox(),
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                isVisibleInfoArticulos =
                                    !isVisibleInfoArticulos;
                              });
                            },
                            child: const Text('Mostrar/Ocultar'),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isVisibleInfoArticulos,
                        child: Text(
                          mostrarDatos(resultsArticulos),
                        ),
                      ),
                      //categorias
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                postgresConnection.selectAllCategories();
                                debugPrint(resultsCategorias.toString());
                              });
                            },
                            child: const Text('Solicitar Categorias '),
                          ),
                          kSizedBox(),
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                isVisibleCategorias = !isVisibleCategorias;
                              });
                            },
                            child: const Text('Mostrar/Ocultar'),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isVisibleCategorias,
                        child: Text(
                          mostrarDatos(resultsCategorias),
                        ),
                      ),
                      //clientes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                postgresConnection.selectAllCustomers();
                                debugPrint(resultsCategorias.toString());
                              });
                            },
                            child: const Text('Solicitar Clientes'),
                          ),
                          kSizedBox(),
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                isVisibleClientes = !isVisibleClientes;
                              });
                            },
                            child: const Text('Mostrar/Ocultar'),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isVisibleClientes,
                        child: Text(
                          mostrarDatos(resultsClientes),
                        ),
                      ),
                      //empleados
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                postgresConnection.selectAllEmployees();
                                debugPrint(resultsCategorias.toString());
                              });
                            },
                            child: const Text('Solicitar Empleados'),
                          ),
                          kSizedBox(),
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                isVisibleEmpleados = !isVisibleEmpleados;
                              });
                            },
                            child: const Text('Mostrar/Ocultar'),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isVisibleEmpleados,
                        child: Text(
                          mostrarDatos(resultsEmpleados),
                        ),
                      ),
                      //proveedores
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                postgresConnection.selectAllProviders();
                                debugPrint(resultsProveedores.toString());
                              });
                            },
                            child: const Text('Solicitar Proveedores'),
                          ),
                          kSizedBox(),
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                isVisibleProveedores = !isVisibleProveedores;
                              });
                            },
                            child: const Text('Mostrar/Ocultar'),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isVisibleProveedores,
                        child: Text(
                          mostrarDatos(resultsProveedores),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                postgresConnection.selectAllBranches();
                                debugPrint(resultsSucursales.toString());
                              });
                            },
                            child: const Text('Solicitar Sucursales'),
                          ),
                          kSizedBox(),
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                isVisibleSucursales = !isVisibleSucursales;
                              });
                            },
                            child: const Text('Mostrar/Ocultar'),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isVisibleSucursales,
                        child: Text(
                          mostrarDatos(resultsSucursales),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                postgresConnection.selectAllTelephones();
                                debugPrint(resultsTelefono.toString());
                              });
                            },
                            child: const Text('Solicitar Teléfonos'),
                          ),
                          kSizedBox(),
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                isVisibleTelefonos = !isVisibleTelefonos;
                              });
                            },
                            child: const Text('Mostrar/Ocultar'),
                          ),
                        ],
                      ),

                      Visibility(
                        visible: isVisibleTelefonos,
                        child: Text(
                          mostrarDatos(resultsTelefono),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                postgresConnection.selectAllSales();
                                debugPrint(resultsVentas.toString());
                              });
                            },
                            child: const Text('Solicitar Ventas'),
                          ),
                          kSizedBox(),
                          TextButton(
                            style: kestiloBotones(),
                            onPressed: () {
                              setState(() {
                                isVisibleVentas = !isVisibleVentas;
                              });
                            },
                            child: const Text('Mostrar/Ocultar'),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isVisibleVentas,
                        child: Text(
                          resultsVentas.toString(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: kestiloBotonCool(),
                            onPressed: () {
                              Navigator.pushNamed(context, 'login');
                              postgresConnection.selectAllEmployees();
                            },
                            child: const Text('Agregar Empleado'),
                          ),
                          kSizedBox(),
                          TextButton(
                            style: kestiloBotonCool(),
                            onPressed: () {
                              Navigator.pushNamed(context, 'eliminar_empleado');
                              postgresConnection.selectAllEmployees();
                            },
                            child: const Text('Eliminar Empleado'),
                          ),
                        ],
                      ),
                      kSizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: kestiloBotonCool(),
                            onPressed: () {
                              Navigator.pushNamed(context, 'categoria');
                              postgresConnection.selectAllEmployees();
                            },
                            child: const Text('Agregar Categoria'),
                          ),
                          kSizedBox(),
                          TextButton(
                            style: kestiloBotonCool(),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, 'eliminar_categoria');
                              postgresConnection.selectAllEmployees();
                            },
                            child: const Text('Eliminar Categoria'),
                          ),
                        ],
                      ),
                      kSizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: kestiloBotonCool(),
                            onPressed: () {
                              Navigator.pushNamed(context, 'telefono');
                              postgresConnection.selectAllEmployees();
                            },
                            child: const Text('Agregar Telefono'),
                          ),
                          kSizedBox(),
                          TextButton(
                            style: kestiloBotonCool(),
                            onPressed: () {
                              Navigator.pushNamed(context, 'eliminar_telefono');
                              postgresConnection.selectAllEmployees();
                            },
                            child: const Text('Eliminar Telefono'),
                          ),
                        ],
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

  SizedBox kSizedBox() {
    return const SizedBox(
      width: 10,
    );
  }

  ButtonStyle kestiloBotones() {
    return ButtonStyle(
      elevation: MaterialStateProperty.all<double>(10),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      backgroundColor: MaterialStateProperty.all<Color>(
        Colors.black38,
      ),
    );
  }

  ButtonStyle kestiloBotonCool() {
    return ButtonStyle(
      elevation: MaterialStateProperty.all<double>(10),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black38),
      backgroundColor: MaterialStateProperty.all<Color>(
        Colors.white,
      ),
    );
  }

  TextButton botonMostrarOcultar(bool isVisible) {
    return TextButton(
      onPressed: () {
        setState(() {
          isVisible = !isVisible;
        });
      },
      child: const Text('Mostrar/Ocultar'),
    );
  }

  mostrarDatos(results) {
    //final List<List<dynamic>> resultados = [];
    final List<List<dynamic>> resultadosFinal = [];

    /*
    for (int i = 0; i < results.length; i++) {
      resultados.add(results[i]);
      for (int j = 0; j < results[i].length; j++) {
        debugPrint(results[i][j].toString());
        //resultados.add(results[i][j]);
        resultados.add(results[j]);
      }
    }
     */

    for (final row in results) {
      resultadosFinal.add(row);
      debugPrint('Renglon $row');
      for (final column in row) {
        debugPrint('Columna $column');
      }
    }

    return resultadosFinal.toString();
  }

  //Le quita el formato al texto de la imagen
  changeValue(String value) {
    //base64.decode(value.replaceAll(RegExp(r'\s+'), ''));
    final newValue = value.replaceAll('[', '').replaceAll(']', '');
    return newValue;
  }

  imageMemoryReady(String value) {
    final newValue = base64.decode(value.replaceAll(RegExp(r'\s+'), ''));
    return newValue;
  }
}

List<dynamic> row = [], column = [];

class MiWidget extends StatelessWidget {
  final List<List<dynamic>> resultsWidget;
  final List<List<dynamic>> resultados = [];

  MiWidget({super.key, required this.resultsWidget});

  recorrerLista(List<List<dynamic>> resultadosWidget) {
    debugPrint('Iniciando Recorrido');
    for (int i = 0; i < resultadosWidget.length; i++) {
      for (int j = 0; j < resultadosWidget[i].length; j++) {
        debugPrint(resultadosWidget[i][j].toString());
        resultados[i][j] = resultadosWidget[i][j];
      }
    }

    for (row in resultsWidget) {
      resultados.add(row);
      debugPrint('row ${row.toString()}');
      for (column in row) {
        debugPrint('column ${column.toString()}');
      }
    }
    return resultados;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: resultados.length,
      itemBuilder: (context, index) {
        return Text(resultados[index].toString());
      },
    );
  }
}
