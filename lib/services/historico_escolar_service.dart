import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ost/models/historico_escolar.dart';
import 'package:ost/services/firebase_service.dart';
import 'package:ost/services/frequencia_aluno_service.dart';
import 'package:ost/services/provas_service.dart';

class HistoricoEscolarService {
  final FirebaseService _firebase = FirebaseService();

  Future<void> createHistoricoEscolar({
    required String alunoID,
    required int anoLetivo,
    required String turmaID,
    required List<Disciplina> disciplinas,
  }) async {
    final String historicoID = "$alunoID-$anoLetivo-$turmaID";
    HistoricoEscolarEntity historicoEscolar = HistoricoEscolarEntity(alunoID: alunoID, anoLetivo: anoLetivo, disciplinas: disciplinas, turmaID: turmaID);
    await _firebase.db.collection("HistoricoEscolar").doc(historicoID).set(historicoEscolar.toMap());
  }

  Future<void> adicionarMediaEFaltasBimestreNaDisciplina({
    required String alunoID,
    required int anoLetivo,
    required String turmaID,
    required String disciplinaID,
    required int bimestre,
  }) async {
    final String historicoID = "$alunoID-$anoLetivo-$turmaID";
    
    ProvasService provasService = ProvasService();
    FrequenciaAlunoService frequenciaAlunoService = FrequenciaAlunoService();

    final mediaBimestralDisciplina = await provasService.getMediaNotasDaDisciplinaBimestre(alunoID: alunoID, disciplinaID: disciplinaID, bimestre: bimestre);
    final totalFaltasBimestre = await frequenciaAlunoService.getTotalFaltasPorBimestre(alunoID: alunoID, disciplinaID: disciplinaID, bimestre: bimestre);
    Bimestre bimestreRegistro = Bimestre(numeroBimestre: bimestre, mediaBimestral: mediaBimestralDisciplina, totalFaltas: totalFaltasBimestre);

    final data = <String, dynamic> {
      "bimestres": bimestreRegistro.toMap(),
    };
    await _firebase.db.collection("HistoricoEscolar").doc(historicoID).update(data);
  }

  Future<HistoricoEscolarEntity> getHistoricoEscolarDeAluno({
    required String alunoID,
    required int anoLetivo,
    required String turmaID,
  }) async {
    final String historicoID = "$alunoID-$anoLetivo-$turmaID";
    DocumentSnapshot snapshot = await _firebase.db.collection("HistoricoEscolar").doc(historicoID).get();

    if(snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      return HistoricoEscolarEntity.fromMap(data);
    } else {
      throw StateError('Documento não encontrado para o nome: ');
    }
  }
}