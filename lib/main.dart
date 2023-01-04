import 'package:codders_postgres/inicio.dart';
import 'package:flutter/material.dart';
import 'package:codders_postgres/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      theme: ThemeData.light().copyWith(
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
        'inicio': (context) => Inicio(),
        'login': (context) => const EmployeeLogin(),
        'buttons_show_sql': (context) => const ButtonsShowSql(),
      },
    );
  }
}
