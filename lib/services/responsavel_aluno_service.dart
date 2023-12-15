import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost/models/aluno.dart';
import 'package:ost/models/responsavel.dart';
import 'package:ost/models/user_data.dart';
import 'package:ost/services/authentication_service.dart';
import 'package:ost/services/firebase_service.dart';
import 'package:ost/services/user_data_service.dart';

class ResponsavelAlunoService {
  final FirebaseService _firebase = FirebaseService();
  final AuthenticationService authService = AuthenticationService();

  Future<void> createResponsavel({
    required String uid,
    required String primeiroNome,
    required String sobrenome,
    required String email,
    required String password,
    required String cpf,
    required String phoneNumber,
    required String avatarURL,
  }) async {
    User? currentUser = _firebase.auth.currentUser;
    if (currentUser != null) {
      String userUID = currentUser.uid;
      ResponsavelEntity responsavel = const ResponsavelEntity(
        alunoID: "",
        alunoFoiVinculado: false,
      );
      UserDataService().setCurrentUserPersonalData(
        uid: userUID,
        primeiroNome: primeiroNome,
        sobrenome: sobrenome,
        cpf: cpf,
        phoneNumber: phoneNumber,
        avatarURL: avatarURL,
        role: "responsavel",
      );
      await _firebase.db
          .collection("responsavel")
          .doc(userUID)
          .set(responsavel.toMap());
    }
  }

  Future<void> createAluno({
    required String primeiroNome,
    required String sobrenome,
    required String dataNascimento,
    required String escolaNome,
    required String avatarURL,
    required String alunoMatricula,
  }) async {
    AlunoEntity aluno = AlunoEntity(
      matricula: alunoMatricula,
      nome: {
        "principal": primeiroNome,
        "sobrenome": sobrenome,
      },
      avatarURL: avatarURL,
      dataNascimento: dataNascimento,
      turmaID: "",
    );

    await _firebase.db
        .collection("aluno")
        .doc(alunoMatricula)
        .set(aluno.toMap());
  }

  Future<void> vincularResponsavelAluno({
    required String responsavelID,
    required String alunoMatricula,
  }) async {
    ResponsavelEntity responsavel =
        ResponsavelEntity(alunoID: alunoMatricula, alunoFoiVinculado: true);
    await _firebase.db
        .collection("responsavel")
        .doc(responsavelID)
        .update(responsavel.toMap());
  }

  Future<List<UserData>> listeResponsaveisNaoVinculados() async {
    List<UserData> responsaveisNaoVinculados = [];
    QuerySnapshot querySnapshot = await _firebase.db
        .collection("responsavel")
        .where("alunoFoiVinculado", isEqualTo: false)
        .get();
    for (var docSnapshot in querySnapshot.docs) {
      if (docSnapshot.exists) {
        final uid = docSnapshot.id;
        final uds = UserDataService();
        UserData responsavel = await uds.getUserByID(uid: uid);
        responsaveisNaoVinculados.add(responsavel);
      } else {
        // throw StateError('erro aqui: ');
        print("nãoaaaaaaaaaaaaaaaaaaa existe");
        // continue;
      }
    }
    return responsaveisNaoVinculados;
  }

  // Future<bool> estaVinculadoResponsavelAluno({required String responsavelID}) async {

  //   if() {

  //   }
  // }
}


  // Future<void> atualizaDadosResponsavelAluno(
  //   String primeiroNome,
  //   String sobrenome,
  //   String cpf,
  //   String phoneNumber,
  //   String graduation,
  // ) async {
  //   User? currentUser = _firebase.auth.currentUser;
  //   if(currentUser != null) {
  //     String userUID = currentUser.uid;
  //     final data = <String, dynamic> {
  //       primeiroNome: primeiroNome, 
  //       sobrenome: sobrenome,
  //       cpf: cpf, 
  //       phoneNumber: phoneNumber,
  //       graduation: graduation,
  //     };

  //     await _firebase.db.collection("ResponsavelAlunoes").doc(userUID).set(data);
  //     await _firebase.db.collection("usuarioDados").doc(userUID).set(data);
  //   }
  // }
  
// }


/*LinkedMap<String, dynamic> linkedMap = ...; //

Map<String, String> stringMap = linkedMap.map((key, value) {
  return MapEntry(key, value.toString());
});*/