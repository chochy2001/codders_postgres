import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class Temp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            Text('Temp', style: TextStyle(fontSize: 30.0, color: Colors.white)),
      ),
    );
  }
}
