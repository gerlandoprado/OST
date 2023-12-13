import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ost/services/firebase_service.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseService().auth;

  Future<AuthStatus> createUser({required String email, required String password}) async {
    AuthStatus _status;
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthenticationExceptionHandler.handleExecption(e);
    }
    return _status;
  }

  Future<AuthStatus> userSignIn({required String email, required String password}) async {
    AuthStatus _status;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthenticationExceptionHandler.handleExecption(e);
    }
    return _status;
  }

  Future<AuthStatus> userSignInWithGoogle() async {
    AuthStatus _status;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _auth.signInWithCredential(credential);
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthenticationExceptionHandler.handleExecption(e);
    }
    return _status;
  }

  Future<void> userLogout() async {
    await _auth.signOut();
  }

  Future<AuthStatus> userResetPassword({required String email}) async {
    AuthStatus _status = AuthStatus.unknown;
    await _auth
      .sendPasswordResetEmail(email: email)
      .then((value) => _status = AuthStatus.successful)
      .catchError((e) => _status = AuthenticationExceptionHandler.handleExecption(e));
    return _status;
  }

  User? get currentUser => _auth.currentUser;
  
}

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  userNotFound,
  operationNotAllowed,
  unknown,
}

class AuthenticationExceptionHandler {
  static handleExecption(FirebaseAuthException e) {
    AuthStatus _status;
    switch (e.code) {
      case "weak-password":
        _status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        _status = AuthStatus.emailAlreadyExists;
        break;
      case "invalid-email":
        _status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        _status = AuthStatus.wrongPassword;
        break;
      case "user-not-found":
        _status = AuthStatus.userNotFound;
        break;
      case "operation-not-allowed":
        _status = AuthStatus.operationNotAllowed;
        break;
      default:
        _status = AuthStatus.unknown;
    }

    return _status;
  }

  static String generateErrorMessage(error) {
    String errorMessage;
    switch (error) {
      case AuthStatus.invalidEmail:
        errorMessage = "formato de email inválido";
        break;
      case AuthStatus.weakPassword:
        errorMessage = "Sua senha deve ser de no mínimo 8 caractestatus";
        break;
      case AuthStatus.wrongPassword:
        errorMessage = "seu email ou senha estão incorretos";
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage = "o email informado já está em uso";
        break;
      default:
        errorMessage = "um erro occoreu, tente novamente mais tarde";
    }
    return errorMessage;
  }
}
