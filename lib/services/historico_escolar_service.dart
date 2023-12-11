import 'package:ost/models/historico_escolar.dart';
import 'package:ost/services/firebase_service.dart';

class HistoricoEscolarService {
  final FirebaseService _firebase = FirebaseService();

  Future<void> createHistoricoEscolar({
    required String alunoID,
    required int anotLetivo,
  }) async {
    
    List<Disciplina> disciplinas = [];
    HistoricoEscolarEntity historicoEscolar = HistoricoEscolarEntity(alunoID: alunoID, anoLetivo: anotLetivo, disciplinas: disciplinas);
    await _firebase.db.collection("HistoricoEscolar").doc().set(historicoEscolar.toMap());
  } 
}