import 'package:codders_postgres/inicio.dart';
import 'package:codders_postgres/screens/screens.dart';
import 'package:codders_postgres/widgets/eliminar_categoria.dart';
import 'package:codders_postgres/widgets/eliminar_empleado.dart';
import 'package:codders_postgres/widgets/eliminar_telefono.dart';
import 'package:codders_postgres/widgets/login_categoria.dart';
import 'package:codders_postgres/widgets/login_telefono.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      theme: ThemeData.light().copyWith(
        iconTheme: const IconThemeData(
          color: Colors.black,
          opacity: 100,
          size: 10,
        ),
        hoverColor: Colors.grey[900],
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: const AppBarTheme(
          elevation: 10,
          color: Colors.black12,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
        focusColor: Colors.grey,
      ),
      //initialRoute: 'buttons_show_sql',
      initialRoute: 'inicio',
      routes: {
        'inicio': (context) => const Inicio(),
        'categoria': (context) => const LoginCategoria(),
        'telefono': (context) => const LoginTelefono(),
        'login': (context) => const EmployeeLogin(),
        'eliminar_empleado': (context) => const EliminarEmpleado(),
        'eliminar_categoria': (context) => const EliminarCategoria(),
        'eliminar_telefono': (context) => const EliminarTelefono(),
        'buttons_show_sql': (context) => const ButtonsShowSql(),
      },
    );
  }
}
