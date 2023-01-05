import 'package:codders_postgres/ui/input_decorations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class LoginCategoria extends StatefulWidget {
  const LoginCategoria({Key? key}) : super(key: key);

  @override
  State<LoginCategoria> createState() => _LoginCategoriaState();
}

class _LoginCategoriaState extends State<LoginCategoria> {
  final TextEditingController idCategoriaController = TextEditingController();
  final TextEditingController nombreCategoriaController =
      TextEditingController();
  final TextEditingController descripcionCategoriaController =
      TextEditingController();
  String idCategoria = '111';
  String nombreCategoria = 'nombre';
  String descripcionCategoria = 'apellido Paterno';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final newConnection = PostgreSQLConnection(
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
    newConnection.open();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Column(
              children: [
                TextFormField(
                  controller: idCategoriaController,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  decoration: InputDecorations.authInputDecoration(
                    hintText: '1234',
                    labelText: 'ID Categoria',
                    prefixIcon: Icons.insert_drive_file_outlined,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'No puede estar vacio';
                    }
                    if (value.contains('.') || value.contains('-')) {
                      return 'El ID no tiene que tener . ni -';
                    } else if (value.length >= 9) {
                      return 'El ID no puede ser tan largo';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                //Nombre
                TextFormField(
                  controller: nombreCategoriaController,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'Juan',
                    labelText: 'Nombre',
                    prefixIcon: Icons.person_outline,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'No puede estar vacio';
                    }
                    if (value.contains('.') ||
                        value.contains('@') ||
                        value.contains('\$') ||
                        value.contains('%') ||
                        value.contains('#') ||
                        value.contains('-')) {
                      return 'No puede tener simbolos especiales';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                //Apellido Paterno
                TextFormField(
                  controller: descripcionCategoriaController,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'Muebles de oficina',
                    labelText: 'Descripción',
                    prefixIcon: Icons.description_outlined,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'No puede estar vacio';
                    }
                    if (value.contains('.') ||
                        value.contains('@') ||
                        value.contains('\$') ||
                        value.contains('%') ||
                        value.contains('#') ||
                        value.contains('-')) {
                      return 'No puede tener simbolos especiales';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Procesando datos'),
                        ),
                      );
                    }
                    setState(() {
                      idCategoria = idCategoriaController.text;
                      nombreCategoria = nombreCategoriaController.text;
                      descripcionCategoria =
                          descripcionCategoriaController.text;
                    });
                  },
                  color: Colors.grey[200],
                  elevation: 10,
                  child: const Text('Validar y Mostrar Datos'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'DATOS INGRESADOS:\n'
                  'ID Categoria: $idCategoria\n'
                  'Nombre: $nombreCategoria\n'
                  'Descripci[on: $descripcionCategoria\n',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      try {
                        debugPrint("se agrego una Categoria");
                        newConnection.query(
                            'insert into categoria (id_categoria,nombre,descripcion) values (@aid_categoria,@anombre,@adescripcion)',
                            substitutionValues: {
                              'aid_categoria': idCategoria,
                              'anombre': nombreCategoria,
                              'adescripcion': descripcionCategoria,
                            });
                      } catch (e) {
                        if (kDebugMode) {
                          print('Esto lo hice yo y este es el error $e');
                        }
                      }
                    });
                  },
                  color: Colors.grey[200],
                  elevation: 10,
                  child: const Text('Crear Categoria'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
