import 'package:flutter/material.dart';

import '../postgres_connection.dart';
import '../widgets/card_container.dart';
import '../widgets/login_form.dart';

class EmployeeLogin extends StatelessWidget {
  const EmployeeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    //Conectandonos a la base de datos
    PostgresConnection postgresConnection = PostgresConnection();
    postgresConnection.connect();

    return SafeArea(
      child: Scaffold(
        body: CardContainer(
          child: ListView(
            children: [
              Column(
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.person_pin_outlined,
                    size: 50,
                    color: Colors.black38,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  'Ingresa los datos del empleado',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
