import 'package:flutter/material.dart';
import 'package:ost/services/authentication_service.dart';
import 'cadastro.dart';
import 'resp-inicio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'OST',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    verificarSessao();
  }

  Future<void> verificarSessao() async {
    AuthenticationService auth = AuthenticationService();
    bool sessaoAtiva = await auth.estaLogado();

    if (sessaoAtiva) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationService auth = AuthenticationService();
    // UserDataService userDataService = UserDataService();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img-login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Entre com sua conta:',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Seu email',
                      contentPadding: const EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Sua senha',
                      contentPadding: const EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () async {
                      String email = _emailController.text;
                      String senha = _passwordController.text;
                      final _status =
                          await auth.userSignIn(email: email, password: senha);
                      if (_status == AuthStatus.successful) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Logado com sucesso!')),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } else {
                        String errorMsg =
                            AuthenticationExceptionHandler.generateErrorMessage(
                                _status);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$errorMsg')),
                        );
                      }
                    },
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 2.0, color: Colors.green),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0), // Add spacing here
                  TextButton(
                    onPressed: () async {
                      // Implementar funcionalidade de esqueci minha senha
                      String email = _emailController.text;
                      final _status = auth.userResetPassword(email: email);
                      if (_status == AuthStatus.successful) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('firebase Msg: $_status')),
                        );
                      } else {
                        String errorMsg =
                            AuthenticationExceptionHandler.generateErrorMessage(
                                _status);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('errorMsg: $errorMsg')),
                        );
                      }
                    },
                    child: const Text(
                      'Esqueceu sua senha?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
