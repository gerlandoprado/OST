import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ost/models/frequencia_aluno.dart';
import 'package:ost/services/firebase_service.dart';

class FrequenciaAlunoService {
  final FirebaseService _firebase = FirebaseService();

  Future<void> createFrequenciaAluno({
    required String alunoID,
    required String disciplinaID,
    required String turmaID,
    required List<RegistroFrequencia> registros,
  }) async {
    final String frequenciaID = "$alunoID-$disciplinaID-$turmaID";
    final registrosFrequencia = [<String, dynamic>{}];
    FrequenciaAlunoEntity frequenciaAluno = FrequenciaAlunoEntity(registro: registrosFrequencia, alunoID: alunoID, disciplinaID: disciplinaID, totalFaltas: 0, turmaID: turmaID);
    await _firebase.db.collection("FrequenciaAluno").doc(frequenciaID).set(frequenciaAluno.toMap());
  }

  Future<void> realizarDiariaFrequenciaAluno({
    required String alunoID,
    required String disciplinaID,
    required String turmaID,
    required bool estaPresente,
    required int bimestre,
  }) async {
    final String frequenciaID = "$alunoID-$disciplinaID-$turmaID";
    final registro = RegistroFrequencia(dataDeHoje: DateTime.now(), estaPresente: estaPresente, bimestre: bimestre);

    if(estaPresente) {
      final atualizarFrequencia = <String, dynamic> {
        "registro": registro.toMap(),
      };
      await _firebase.db.collection("turma")
      .doc(turmaID)
      .collection("FrequenciaAluno")
      .doc(frequenciaID)
      .update(atualizarFrequencia);
    } else {
      final atualizarFrequencia = <String, dynamic> {
        "registro": registro.toMap(),
        "totalFaltas": FieldValue.increment(1),
      };
      await _firebase.db.collection("turma")
      .doc(turmaID)
      .collection("FrequenciaAluno")
      .doc(frequenciaID)
      .update(atualizarFrequencia);
    }
  }

  Future<int> getTotalFaltasPorBimestre({required String alunoID, required String disciplinaID, required int bimestre}) async {
    final snapshot = await _firebase.db.collection("frequenciaAluno")
      .where("alunoID", isEqualTo: alunoID)
      .where("disciplinaID", isEqualTo: disciplinaID)
      .limit(1)
      .get();

    final doc = snapshot.docs.first;
    if (doc.exists) {
      final data = doc.data();
      return data["totalFaltas"];
    } else {
      throw StateError('Documento não encontrado para o nome: ');
    }
  }
}