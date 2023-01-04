import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Muebleria Codders',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Image.network(
                'https://img.freepik.com/vector-gratis/sillon-lampara-muebles-logotipo-empresa-comercial_23-2148462519.jpg?w=1060&t=st=1672796033~exp=1672796633~hmac=ecf123e098c50456c9eb3186eb3dc4ce8cd2056638e77f30e6b3adb106f9bdd5',
              ),
              //leave some space
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'buttons_show_sql');
                  },
                  color: Colors.grey[200],
                  child: const Text("Ir al inicio")),
            ],
          ),
        ),
      ),
    );
  }
}
