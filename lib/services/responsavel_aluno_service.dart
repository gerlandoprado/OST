import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost/models/aluno.dart';
import 'package:ost/models/responsavel.dart';
import 'package:ost/services/authentication_service.dart';
import 'package:ost/services/firebase_service.dart';
import 'package:ost/services/user_data_service.dart';

class ResponsavelAlunoService {
  final FirebaseService _firebase = FirebaseService();
  final AuthenticationService authService = AuthenticationService();

  Future<void> createResponsavel({
    required String primeiroNome,
    required String sobrenome,
    required String email,
    required String password,
    required String cpf,
    required String phoneNumber,
    required String avatarURL,
    required String alunoMatricula,
  }) async {
    User? currentUser = _firebase.auth.currentUser;
    if (currentUser != null) {
      String userUID = currentUser.uid;
      ResponsavelEntity responsavel =
          const ResponsavelEntity(alunoID: "", alunoFoiVinculado: false);
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
    await _firebase.db
        .collection("responsavel")
        .doc(responsavelID)
        .update({"alunoID": alunoMatricula});
  }
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