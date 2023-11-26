import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importe o pacote para usar TextInputFormatters.
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela de Login',
      home: LoginPage(),
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.green,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usuarioController,
              decoration: const InputDecoration(labelText: 'CPF'),
              keyboardType: TextInputType
                  .number, // Define o tipo de teclado para números.
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Aceita apenas números.
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                print('Clicou em Esqueci minha senha');
              },
              child: const Text(
                'Esqueci minha senha',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                print('Clicou em Entrar');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                minimumSize: Size(double.infinity, 60),
              ),
              child: const Text(
                'Entrar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
