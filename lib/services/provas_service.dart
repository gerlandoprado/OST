import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ost/models/prova_agendada.dart';
import 'package:ost/services/firebase_service.dart';

class ProvasService {
  final FirebaseService _firebase = FirebaseService();

  Future<void> createProvaAgendada({
    required String titulo,
    required String descricao,
    required int bimestre,
    required DateTime dataAplicacao,
    required String disciplinaID,
    required String professorID,
    required String turmaID,
  }) async {
    String provaAgendadaID = "$titulo-$turmaID";
    ProvaAgendadaEntity prova = ProvaAgendadaEntity(titulo: titulo, descricao: descricao, bimestre: bimestre, dataAplicacao: dataAplicacao, professorID: professorID, disciplinaID: disciplinaID, turmaID: turmaID);
    await _firebase.db.collection("provasAgendadas").doc(provaAgendadaID).set(prova.toMap());

    final referenciaDeNotaProva = <String, dynamic>{
      "provaID": provaAgendadaID,
      "professorID": professorID,
      "turmaID": turmaID,
    };

    await _firebase.db.collection("notaProva").doc(provaAgendadaID).set(referenciaDeNotaProva);
  }

  Future<List<ProvaAgendadaEntity>> getAllByTurma({required String nomeTurma}) async {
    QuerySnapshot snapshot = await _firebase.db.collection("provasAgendadas").where("turmaID", isEqualTo: nomeTurma).get();

    if (snapshot.docs.isNotEmpty) {
      List<ProvaAgendadaEntity> provasAgendadas = [];
      for (var docSnapshot in snapshot.docs) {
        var data = docSnapshot.data() as Map<String, dynamic>;
        provasAgendadas.add(ProvaAgendadaEntity.fromMap(data));
      }
      return provasAgendadas;
    } else {
      throw StateError('Documento não encontrado para turma');
    }
  }

  Future<void> atribuirNotaDeProva({required String provaID, required String alunoID, required String professorID,required int nota, required String comentario}) async {
    RegistroDeNota registroNota = RegistroDeNota(alunoID: alunoID, nota: nota, comentario: comentario);
    NotaProvaEntity notaProva = NotaProvaEntity(provaID: provaID, professorID: professorID, registros: [registroNota]);
    await _firebase.db.collection("notaProva").doc(provaID).update(notaProva.toMap());
  }

  Future<double> getMediaNotasDaDisciplinaBimestre({required String alunoID, required String disciplinaID, required int bimestre}) async {
    final queryDocs = await _firebase.db.collection("notaProva")
      .where("alunoID", isEqualTo: alunoID)
      .where("disciplinaID", isEqualTo: disciplinaID)
      .where("bimestre", isEqualTo: bimestre)
      .get();

    if(queryDocs.docs.isNotEmpty) {
      double mediaBimestral = 0;
      int quantidadeProvas = 1;
      for (var docSnapshot in queryDocs.docs) {
        final nota = docSnapshot["nota"];
        mediaBimestral += nota;
        quantidadeProvas++;
      }
      mediaBimestral = mediaBimestral / quantidadeProvas;
      return mediaBimestral;
    } else {
      throw StateError('Documento não encontrado para o nome: ');
    }
  }

}