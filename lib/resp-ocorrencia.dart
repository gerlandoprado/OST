import 'package:flutter/material.dart';
import 'perfil.dart';

class OcorrenciaScreen extends StatelessWidget {
  const OcorrenciaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ocorrência'),
        actions: const <Widget>[
          UserProfileButton(),
          SizedBox(width: 10),
        ],
      ),
      body: const Center(
        child: Text('Nenhuma ocorrência registrada.'),
      ),
    );
  }
}
