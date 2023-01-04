import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../postgres_connection.dart';

class TelefonosList extends StatefulWidget {
  const TelefonosList({super.key, required telefonos});

  @override
  State<TelefonosList> createState() => _TelefonosListState();
}

class _TelefonosListState extends State<TelefonosList> {
  List<List<dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    selectAllTelephones().then((value) {
      setState(() {
        results = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final row = results[index];
        return ListTile(
          title: Text(row[1]), // Mostrar el segundo campo de la fila
          subtitle: Text(row[2]), // Mostrar el tercer campo de la fila
        );
      },
    );
  }

  selectAllTelephones() async {
    List<List<dynamic>> results =
        await connection.query("Select * from telefono");
    debugPrint("seleccion de todos los tel");

    for (final row in results) {
      if (kDebugMode) {
        print(row);
      }
    }
    return results;
  }
}
