import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost/services/firebase_service.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseService().authentication;

  Future<String> createUser({required String email, required String password}) async {
    String res = "usuario criado com sucesso";
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      res = "nao foi possivel criar usuario: ${e.code}";
    }
    return res;
  }

  Future<String> userSignIn({required String email, required String password}) async {
    String res = "usuario logado com sucesso";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      res = "nao foi possivel fazer login: ${e.code}";
    }
    return res;
  }

  Future<String> userLogout() async {
    String res = "logout de usuario efetuado com sucesso";
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      res = "nao foi possivel fazer logout do usuario: ${e.code}";
    }
    return res;
  }
}
