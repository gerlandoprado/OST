import 'package:flutter/material.dart';
import 'perfil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aprovação de Cadastro',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TelaAprovacaoCadastro(),
    );
  }
}

class TelaAprovacaoCadastro extends StatelessWidget {
  const TelaAprovacaoCadastro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
        actions: const <Widget>[
          UserProfileButton(), // Botão do perfil do usuário
          SizedBox(width: 10),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.hourglass_empty,
                size: 50), // Ícone de aprovação pendente
            SizedBox(height: 20),
            Text('Seu cadastro está aguardando aprovação. Aguarde.'),
          ],
        ),
      ),
    );
  }
}
