import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost/models/user_data.dart';
import 'package:ost/services/firebase_service.dart';

class UserService {
  final FirebaseService _firebase = FirebaseService();

  Future<void> setUserPersonalData({
    required Map name,
    required String cpf,
    required String phoneNumber,
    required String avatarURL,
  }) async {
    User? currentUser = _firebase.auth.currentUser;
    if(currentUser == null) {
      // error
    }

    String uid = currentUser!.uid;
    UserData userData = UserData(
      uid: uid,
      name: name,
      cpf: cpf,
      avatarURL: avatarURL,
      phoneNumber: phoneNumber,
    );

    await _firebase.db.collection("usuarioDados").doc(currentUser.uid).set(userData.toMap());
  }
}