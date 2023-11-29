import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost/models/professor.dart';
import 'package:ost/services/firebase_service.dart';
import 'package:ost/services/user_data_service.dart';

class ProfessorService {
  final FirebaseService _firebase = FirebaseService();

  Future<void> createProfessor({
    required String firstName,
    required String lastName,
    required String cpf,
    required String phoneNumber,
    required String avatarURL,
    required String graduation,
  }) async {
    User? currentUser = _firebase.auth.currentUser;
    if(currentUser != null) {
      String userUID = currentUser.uid;
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

  

  
}