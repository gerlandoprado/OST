import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ost/models/user_data.dart';
import 'package:ost/services/firebase_service.dart';

class UserDataService {
  final FirebaseService _firebase = FirebaseService();

  Future<void> setCurrentUserPersonalData({
    required String uid,
    required String primeiroNome,
    required String sobrenome,
    required String cpf,
    required String phoneNumber,
    required String avatarURL,
    required String role,
  }) async {
    UserData userData = UserData(
      primeiroNome: primeiroNome,
      sobrenome: sobrenome,
      cpf: cpf,
      avatarURL: avatarURL,
      telefone: phoneNumber,
      role: role,
    );

    // final nome = {
    //   "primeiro": primeiroNome,
    //   "sobrenome": sobrenome,
    // };

    // var data = <String, dynamic>{
    //   "avatarURL": avatarURL,
    //   "cpf": cpf,
    //   "nome": nome,
    //   "role": role,
    //   "telefone": phoneNumber,
    // };

    // IMPORTANTE: usuarioDados é associado com um usuario autenticado, então devem ter o mesmo uid
    await _firebase.db
        .collection("usuarioDados")
        .doc(uid)
        .set(userData.toMap())
        .onError((e, _) => print("Error writing document: $e"));
  }

  Future<UserData> getUserIDByCPF({required String cpf}) async {
    QuerySnapshot docSnapshot = await _firebase.db
        .collection("usuarioDados")
        .where("cpf", isEqualTo: cpf)
        .limit(1)
        .get();
    if (docSnapshot.docs.isNotEmpty) {
      final data = docSnapshot.docs.first.data() as Map<String, dynamic>;
      return UserData.fromMap(data);
    } else {
      throw StateError('Documento não encontrado para o nome: ');
    }
  }

  Future<UserData> getUserByID({required String uid}) async {
    DocumentSnapshot docSnapshot =
        await _firebase.db.collection("usuarioDados").doc(uid).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      return UserData.fromMap(data);
    } else {
      throw StateError('seila etst o nome: ');
    }
  }
}
