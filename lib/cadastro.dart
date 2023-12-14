import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:ost/services/authentication_service.dart';
import 'package:ost/services/user_data_service.dart';
import 'resp-inicio.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cpfController = MaskedTextController(mask: '000.000.000-00');
  final _emailController = TextEditingController();
  final _phoneController = MaskedTextController(mask: '(00) 0 0000-0000');
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthenticationService auth = AuthenticationService();
    UserDataService userDataService = UserDataService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Primeiro Nome',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu nome completo';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Sobrenome',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu nome completo';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _cpfController,
              decoration: const InputDecoration(
                labelText: 'CPF',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu nome completo';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Por favor, insira um email válido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Telefone',
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 15) {
                  return 'Por favor, insira um telefone válido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                        .hasMatch(value)) {
                  return 'A senha deve conter letras e números';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirmar senha',
              ),
              obscureText: true,
              validator: (value) {
                if (value != _passwordController.text) {
                  return 'As senhas não coincidem';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String nome = _nameController.text;
                String sobrenome = _lastNameController.text;
                String cpf = _cpfController.text;
                String email = _emailController.text;
                String telefone = _phoneController.text;
                String senha = _passwordController.text;

                if (_formKey.currentState!.validate()) {
                  // Codigo para backend aqui
                  var _status =
                      await auth.createUser(email: email, password: senha);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('firebase status: $_status')),
                  );

                  _status =
                      await auth.userSignIn(email: email, password: senha);
                  if (_status == AuthStatus.successful) {
                    String userUID = auth.currentUser!.uid;
                    await userDataService.setCurrentUserPersonalData(
                        uid: userUID,
                        primeiroNome: nome,
                        sobrenome: sobrenome,
                        cpf: cpf,
                        phoneNumber: telefone,
                        avatarURL: "./qualquerCoisaSoUmTeste.png",
                        role: "responsavel");
                  } else {
                    String errorMsg =
                        AuthenticationExceptionHandler.generateErrorMessage(
                            _status);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('errorMsg: $errorMsg')),
                    );
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
