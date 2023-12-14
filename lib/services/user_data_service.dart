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
      nome: {
        "primeiro": primeiroNome,
        "sobrenome": sobrenome,
      },
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
}
