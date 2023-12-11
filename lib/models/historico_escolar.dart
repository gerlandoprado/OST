import 'package:flutter/foundation.dart';

@immutable
class HistoricoEscolarEntity {
  final String alunoID;
  final int anoLetivo; 
  final List<Disciplina> disciplinas; 

  const HistoricoEscolarEntity({
    required this.alunoID,
    required this.anoLetivo,
    required this.disciplinas,
  });

  factory HistoricoEscolarEntity.fromMap(Map<String, dynamic> map ) {
    return HistoricoEscolarEntity(
      alunoID: map['alunoID'],
      anoLetivo: map['anoLetivo'],
      disciplinas: (map['disciplinas'] as List<dynamic>).map((disciplinaMap) {
        return Disciplina.fromMap(disciplinaMap);
      }).toList(),
    );
}


  Map<String, dynamic> toMap() {
    return {
      'alunoID': alunoID,
      'anoLetivo': anoLetivo,
      'disciplinas': disciplinas,
    };
  }


}

class Disciplina {
  final String uid;
  final List<Bimestre> bimestres;

  const Disciplina({
    required this.uid,
    required this.bimestres,
  });

  factory Disciplina.fromMap(Map<String, dynamic> map) {
    return Disciplina(
      uid: map['uid'],
      bimestres: (map['bimestres'] as List<dynamic>).map((bimestre) => Bimestre.fromMap(bimestre)).toList(),
    );
  }
}

class Bimestre {
  final int numeroBimestre;
  final double mediaBimestral;
  final int totalFaltas;

  const Bimestre({
    required this.numeroBimestre,
    required this.mediaBimestral,
    required this.totalFaltas,
  });

  factory Bimestre.fromMap(Map<String, dynamic> map) {
    return Bimestre(
      numeroBimestre: map['numeroBimestre'],
      mediaBimestral: map['mediaBimestral'],
      totalFaltas: map['totalFaltas'],
    );
  }
}
