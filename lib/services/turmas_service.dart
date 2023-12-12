import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ost/models/turmas.dart';
import 'package:ost/services/firebase_service.dart';

class TurmasService {
  final FirebaseService _firebase = FirebaseService();

  Future<void> createTurma({
    required String nome,
    required String sala,
    required int anoLetivo,
    required String turno,
    
  }) async {
    TurmaEntity turma = TurmaEntity(nome: nome, anoLetivo: anoLetivo, sala: sala, turno: turno);
    await _firebase.db.collection("turmas").doc(nome).set(turma.toMap());
  }

  Future<TurmaEntity> getTurmaByName({required String nome}) async {
    DocumentSnapshot snapshot = await _firebase.db.collection("turmas").doc(nome).get();

    if (snapshot.exists) {
      var turmaMap = snapshot.data() as Map<String, dynamic>;
      return TurmaEntity.fromMap(turmaMap);
    } else {
      throw StateError('Documento não encontrado para o nome: $nome');
    }
  }
}