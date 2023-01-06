import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import '../ui/input_decorations.dart';

class LoginTelefono extends StatefulWidget {
  const LoginTelefono({super.key});

  @override
  LoginTelefonoState createState() => LoginTelefonoState();
}

class LoginTelefonoState extends State<LoginTelefono> {
  final TextEditingController numTelController = TextEditingController();
  final TextEditingController telefonoEmpleadoController =
      TextEditingController();
  final TextEditingController idEmpleadoController = TextEditingController();
  String numTel = '111';
  String telefonoEmpleado = 'nombre';
  String idEmpleado = 'apellido Paterno';

  final _formKey = GlobalKey<FormState>();
  String e = '';

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
                  controller: numTelController,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  decoration: InputDecorations.authInputDecoration(
                    hintText: '1234',
                    labelText: 'id Tel',
                    prefixIcon: Icons.phone,
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
                  controller: telefonoEmpleadoController,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: '5534987557',
                    labelText: 'telefono Empleado',
                    prefixIcon: Icons.person_outline,
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
                //Apellido Paterno
                TextFormField(
                  controller: idEmpleadoController,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'i123455',
                    labelText: 'id Empleado "315289014"',
                    prefixIcon: Icons.description_outlined,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'No puede estar vacio';
                    }
                    if (value.contains('.') || value.contains('-')) {
                      return 'El ID no tiene que tener . ni -';
                    } else if (value.length > 10) {
                      return 'El ID no puede ser tan largo';
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
                      numTel = numTelController.text;
                      telefonoEmpleado = telefonoEmpleadoController.text;
                      idEmpleado = idEmpleadoController.text;
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
                  'ID Categoria: $numTel\n'
                  'Nombre: $telefonoEmpleado\n'
                  'Descripción: $idEmpleado\n',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      try {
                        newConnection.query(
                            'insert into telefono(num_tel,telefono_empleado,id_empleado) values (@anum_tel,@atelefono,@aid_empleado)',
                            substitutionValues: {
                              'anum_tel': numTel,
                              'atelefono': telefonoEmpleado,
                              'aid_empleado': idEmpleado,
                            });
                        debugPrint("se agrego un Telefono");
                      } catch (error) {
                        e = error.toString();
                        if (kDebugMode) {
                          print('Error $e');
                          throw Exception('Error $e');
                        }
                      }
                    });
                  },
                  color: Colors.grey[200],
                  elevation: 10,
                  child: const Text('Crear Telefono'),
                ),
                Visibility(
                  visible: e != '',
                  child: const Text(
                    'Unhandled Exception: PostgreSQL Severity.error',
                  ),

                  /*
                  child: ErrorWidget(e),
                  Text(e),
                       */
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
