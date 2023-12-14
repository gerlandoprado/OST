import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost/models/professor.dart';
import 'package:ost/services/authentication_service.dart';
import 'package:ost/services/firebase_service.dart';
import 'package:ost/services/user_data_service.dart';

class ProfessorService {
  final FirebaseService _firebase = FirebaseService();
  final AuthenticationService authService = AuthenticationService();

  Future<void> createProfessor({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String cpf,
    required String phoneNumber,
    required String avatarURL,
    required String graduation,
  }) async {
    User? currentUser = _firebase.auth.currentUser;
    if(currentUser != null) {
      User? user = await authService.createUser(email: email, password: password);
      String userUID = user!.uid;
      ProfessorEntity professor = ProfessorEntity(uid: userUID, graduation: graduation, accountAproved: false);
      UserDataService().setCurrentUserPersonalData(
        uid: userUID,
        firstName: firstName, 
        lastName: lastName,
        cpf: cpf, 
        phoneNumber: phoneNumber, 
        avatarURL: avatarURL, 
        role: "discente",
      );
      await _firebase.db.collection("professores").doc(userUID).set(professor.toMap());
    }
  }

  Future<void> atualizaDadosProfessor(
    String firstName,
    String lastName,
    String cpf,
    String phoneNumber,
    String graduation,
  ) async {
    User? currentUser = _firebase.auth.currentUser;
    if(currentUser != null) {
      String userUID = currentUser.uid;
      final data = <String, dynamic> {
        firstName: firstName, 
        lastName: lastName,
        cpf: cpf, 
        phoneNumber: phoneNumber,
        graduation: graduation,
      };

      await _firebase.db.collection("professores").doc(userUID).set(data);
      await _firebase.db.collection("usuarioDados").doc(userUID).set(data);
    }
  }
  
}