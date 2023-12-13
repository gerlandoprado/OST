import 'package:flutter/foundation.dart';

@immutable
class FrequenciaAlunoEntity {
  final String alunoID;
  final String disciplinaID;
  final String turmaID;
  final int totalFaltas;
  final List<Map<String, dynamic>> registro;

  const FrequenciaAlunoEntity({
    required this.registro,
    required this.totalFaltas,
    required this.alunoID,
    required this.disciplinaID,
    required this.turmaID,
  });

  factory FrequenciaAlunoEntity.fromMap(Map<String, dynamic> map ) {
    return FrequenciaAlunoEntity(
      alunoID: map['alunoID'],
      totalFaltas: map['totalFaltas'],
      disciplinaID: map['disciplinaID'],
      turmaID: map['turmaID'],
      registro: map['registro'],  
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alunoID': alunoID,
      'totalFaltas': totalFaltas,
      'disciplinaID': disciplinaID,
      'turmaID': turmaID,
      'registro': registro,
    };
  }
}

class RegistroFrequencia {
  final DateTime dataDeHoje;
  final bool estaPresente;
  final int bimestre;

  const RegistroFrequencia({
    required this.dataDeHoje,
    required this.estaPresente,
    required this.bimestre,
  });

  Map<String, dynamic> toMap() {
    return {
      'dataDeHoje': dataDeHoje,
      'estaPresente': estaPresente,
      'bimestre': bimestre,
    };
  }

  factory RegistroFrequencia.fromMap(Map<String, dynamic> map) {
    return RegistroFrequencia(
      dataDeHoje: map['dataDeHoje'],
      estaPresente: map['estaPresente'],
      bimestre: map['bimestre'],
    );
  }
}