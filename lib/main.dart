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
        hoverColor: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: const AppBarTheme(
          elevation: 10,
          color: Colors.deepPurple,
        ),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple),
        focusColor: Colors.deepPurple,
      ),
      initialRoute: 'buttons_show_sql',
      routes: {
        'login': (context) => const EmployeeLogin(),
        'buttons_show_sql': (context) => const ButtonsShowSql(),
      },
    );
  }
}
