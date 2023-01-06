import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../ui/input_decorations.dart';
import 'package:postgres/postgres.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController idEmpleadoController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoPaternoController =
      TextEditingController();
  final TextEditingController apellidoMaternoController =
      TextEditingController();
  final TextEditingController curpController = TextEditingController();
  final TextEditingController rfcController = TextEditingController();
  final TextEditingController fechaIngresoController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numeroExteriorController =
      TextEditingController();
  final TextEditingController numeroInteriorController =
      TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController codigoPostalController = TextEditingController();
  final TextEditingController calleController = TextEditingController();
  final TextEditingController idSucursalController = TextEditingController();
  final TextEditingController idSupervisorController = TextEditingController();
  String idEmpleado = '111';
  String nombre = 'nombre';
  String apellidoPaterno = 'apellido Paterno';
  String apellidoMaterno = 'apellido Materno';
  String curp = 'curp';
  String rfc = 'rfc';
  String fechaIngreso = 'fecha Ingreso';
  String tipo = 'tipo';
  String email = 'email';
  String numeroExterior = 'ex123';
  String numeroInterior = 'in123';
  String codigoPostal = 'cp04531';
  String calle = 'calle ';
  String idSucursal = 'idsuc123';
  String idSupervisor = 'idSup123';

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

    return Form(
      key: _formKey,
      child: Column(
        children: [
          //ID Empleado
          TextFormField(
            controller: idEmpleadoController,
            autocorrect: false,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 15, color: Colors.black),
            decoration: InputDecorations.authInputDecoration(
              hintText: '1234',
              labelText: 'ID Empleado',
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
            controller: nombreController,
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
            controller: apellidoPaternoController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Perez',
              labelText: 'Apellido Paterno',
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
          //Apellido Materno
          TextFormField(
            controller: apellidoMaternoController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Gonzalez',
              labelText: 'Apellido Materno',
              prefixIcon: Icons.person_outline,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //Curp
          TextFormField(
            controller: curpController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'OEAF771122HDFLNS09',
              labelText: 'Curp',
              prefixIcon: Icons.account_box_outlined,
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'No puede estar vacio';
              }
              if (value.length < 18) {
                return 'Curp inválido <(18 caracteres)';
              }
              if (value.length > 18) {
                return 'Curp inválido  > (18 caracteres)';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          //RFC
          TextFormField(
            controller: rfcController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'FAGJ090412SU2',
              labelText: 'RFC',
              prefixIcon: Icons.account_box_outlined,
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
              } else if (value.length < 12) {
                return 'RFC inválido *muy corto* (13 digitos)';
              } else if (value.length > 13) {
                return 'RFC inválido *muy largo* (13 digitos)';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          //fechaIngreso
          TextFormField(
            controller: fechaIngresoController,
            autocorrect: false,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
            ),
            decoration: InputDecorations.authInputDecoration(
              hintText: '2021-01-01',
              labelText: 'Fecha de Ingreso',
              prefixIcon: Icons.date_range_rounded,
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'No puede estar vacio';
              }
              if (value.contains('.') ||
                  value.contains('@') ||
                  value.contains('\$') ||
                  value.contains('%') ||
                  value.contains('#')) {
                return 'No puede tener simbolos especiales';
              } else if (!value.contains('-')) {
                return 'Formato de fecha inválido 0000-00-00';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          //Tipo Empleado
          TextFormField(
            controller: tipoController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'V',
              labelText: 'Tipo de Empleado (V o C o L o S)',
              prefixIcon: Icons.type_specimen_outlined,
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'No puede estar vacio';
              }
              if (value.length == 1 ||
                  !value.contains('V') ||
                  !value.contains('C') ||
                  !value.contains('S') ||
                  !value.contains('L')) {
                return null;
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
          //Email
          TextFormField(
            controller: emailController,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo Electronico',
              prefixIcon: Icons.alternate_email_outlined,
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'No puede estar vacio';
              }
              if (!value.contains('@')) {
                return 'Tiene que tener un @';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          //Numero Exterior
          TextFormField(
            controller: numeroExteriorController,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecorations.authInputDecoration(
              hintText: '123',
              labelText: 'Numero Exterior',
              prefixIcon: Icons.numbers_outlined,
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
              } else if (value.contains('a') ||
                  value.contains('e') ||
                  value.contains('i') ||
                  value.contains('o') ||
                  value.contains('u')) {
                return 'No puede tener letras';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          //Numero Interior
          TextFormField(
            controller: numeroInteriorController,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecorations.authInputDecoration(
              hintText: '123',
              labelText: 'Numero Interior',
              prefixIcon: Icons.numbers_outlined,
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
              } else if (value.contains('a') ||
                  value.contains('e') ||
                  value.contains('i') ||
                  value.contains('o') ||
                  value.contains('u')) {
                return 'No puede tener letras';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          //Estado
          TextFormField(
            controller: estadoController,
            autocorrect: false,
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'CDMX',
              labelText: 'Estado',
              prefixIcon: Icons.location_city_outlined,
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
          //Codigo Postal
          TextFormField(
            controller: codigoPostalController,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecorations.authInputDecoration(
              hintText: '04333',
              labelText: 'Codigo Postal',
              prefixIcon: Icons.code,
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
              } else if (value.contains('a') ||
                  value.contains('e') ||
                  value.contains('i') ||
                  value.contains('o') ||
                  value.contains('u')) {
                return 'No puede tener letras';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          //Calle
          TextFormField(
            controller: calleController,
            autocorrect: false,
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Calle 13',
              labelText: 'Calle',
              prefixIcon: Icons.location_city_outlined,
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
          //ID Sucursal
          TextFormField(
            controller: idSucursalController,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecorations.authInputDecoration(
              hintText: '713333',
              labelText: 'ID Sucursal "713333"',
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
              if (value.contains('.') ||
                  value.contains('@') ||
                  value.contains('\$') ||
                  value.contains('%') ||
                  value.contains('#') ||
                  value.contains('-')) {
                return 'No puede tener simbolos especiales';
              } else if (value.contains('a') ||
                  value.contains('e') ||
                  value.contains('i') ||
                  value.contains('o') ||
                  value.contains('u')) {
                return 'No puede tener letras';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          //ID Empleado1
          TextFormField(
            controller: idSupervisorController,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecorations.authInputDecoration(
              hintText: '418759684',
              labelText: 'ID Supervisor "418759684"',
              prefixIcon: Icons.insert_drive_file_outlined,
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'No puede estar vacio';
              }
              if (value.contains('.') || value.contains('-')) {
                return 'El ID no tiene que tener . ni -';
              } else if (value.length > 9) {
                return 'El ID no puede ser tan largo';
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
                idEmpleado = idEmpleadoController.text;
                nombre = nombreController.text;
                apellidoPaterno = apellidoPaternoController.text;
                apellidoMaterno = apellidoMaternoController.text;
                curp = curpController.text;
                rfc = rfcController.text;
                fechaIngreso = fechaIngresoController.text;
                tipo = tipoController.text;
                email = emailController.text;
                numeroExterior = numeroExteriorController.text;
                numeroInterior = numeroInteriorController.text;
                codigoPostal = codigoPostalController.text;
                calle = calleController.text;
                idSucursal = idSucursalController.text;
                idSupervisor = idSupervisorController.text;
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
            'ID Empleado: $idEmpleado\n'
            'Nombre: $nombre\n'
            'Apellido Paterno: $apellidoPaterno\n'
            'Apellido Materno: $apellidoMaterno\n'
            'Curp: $curp\n'
            'RFC: $rfc\n'
            'Fecha Ingreso: $fechaIngreso\n'
            'Tipo Empleado: $tipo\n'
            'Correo Electronico: $email\n'
            'Numero Exterior: $numeroExterior\n'
            'Numero Interior: $numeroInterior\n'
            'Codigo Postal: $codigoPostal\n'
            'Calle: $calle\n'
            'ID Sucursal: $idSucursal\n'
            'ID Supervisor: $idSupervisor\n',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          MaterialButton(
            onPressed: () {
              setState(() {
                try {
                  debugPrint("se agrego un empleado");
                  newConnection.query(
                      'insert into empleado (id_empleado,curp,rfc,nombre,apellido_paterno,apellido_materno,fecha_ingreso,tipo,email,numero_exterior,numero_interior,codigo_postal,calle,id_sucursal,id_empleado1) values (@aid_empleado,@acurp,@arfc,@anombre,@aapellido_paterno,@aapellido_materno,@afecha_ingreso,@atipo,@aemail,@anumero_exterior,@anumero_interior,@acodigo_postal,@acalle,@aid_sucursal,@aid_empleado1)',
                      substitutionValues: {
                        'aid_empleado': idEmpleado,
                        'acurp': curp,
                        'arfc': rfc,
                        'anombre': nombre,
                        'aapellido_paterno': apellidoPaterno,
                        'aapellido_materno': apellidoMaterno,
                        'afecha_ingreso': fechaIngreso,
                        'atipo': tipo,
                        'aemail': email,
                        'anumero_exterior': numeroExterior,
                        'anumero_interior': numeroInterior,
                        'acodigo_postal': codigoPostal,
                        'acalle': calle,
                        'aid_sucursal': idSucursal,
                        'aid_empleado1': idSupervisor,
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
            child: const Text('Crear Empleado'),
          ),
        ],
      ),
    );
  }
}
