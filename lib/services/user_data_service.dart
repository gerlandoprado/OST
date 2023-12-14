import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ost/models/user_data.dart';
import 'package:ost/services/firebase_service.dart';

class UserDataService {
  final FirebaseService _firebase = FirebaseService();

  Future<void> setCurrentUserPersonalData({
    required String uid,
    required String firstName,
    required String lastName,
    required String cpf,
    required String phoneNumber,
    required String avatarURL,
    required String role,
  }) async {

      UserData userData = UserData(
        uid: uid,
        name: {
          firstName: firstName, 
          lastName: lastName,
        }, 
        cpf: cpf,
        avatarURL: avatarURL,
        phoneNumber: phoneNumber,
        role: role,
      );

      // IMPORTANTE: usuarioDados é associado com um usuario autenticado, então devem ter o mesmo uid
      await _firebase.db.collection("usuarioDados").doc(uid).set(userData.toMap());
  }

  Future<String> getUserIDByCPF({required String cpf}) async {
      QuerySnapshot docSnapshot = await _firebase.db.collection("usuarioDados").where("cpf", isEqualTo: cpf).get();
      if (docSnapshot.docs.isNotEmpty) {
        return docSnapshot.docs.first.id;
      } else {
        throw StateError('Documento não encontrado para o nome: ');
      }
  }
}