import 'package:flutter/foundation.dart';

@immutable
class ProvaAgendadaEntity {
  final String titulo;
  final String descricao;
  final int bimestre;
  final DateTime dataAplicacao;
  final String professorID;
  final String disciplinaID;
  final String turmaID;

  const ProvaAgendadaEntity({
    required this.titulo,
    required this.descricao,
    required this.bimestre,
    required this.dataAplicacao,
    required this.professorID,
    required this.disciplinaID,
    required this.turmaID,
  });

  factory ProvaAgendadaEntity.fromMap(Map<String, dynamic> map ) {
    return ProvaAgendadaEntity(
      titulo: map['titulo'],
      descricao: map['descricao'],
      bimestre: map['bimestre'],
      dataAplicacao: map['dataAplicacao'],
      professorID: map['professorID'],
      disciplinaID: map['disciplinaID'],
      turmaID: map['turmaID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'bimestre': bimestre,
      'dataAplicacao': dataAplicacao,
      'professorID': professorID,
      'disciplinaID': disciplinaID,
      'turmaID': turmaID,
    };
  }
}

@immutable
class NotaProvaEntity {
  final String provaID;
  final String professorID;
  final List<RegistroDeNota> registros;

  const NotaProvaEntity({
    required this.provaID,
    required this.professorID,
    required this.registros,
  });

  factory NotaProvaEntity.fromMap(Map<String, dynamic> map ) {
    return NotaProvaEntity(
      provaID: map['provaID'],
      professorID: map['professorID'],
      registros: map['registros'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'provaID': provaID,
      'professorID': professorID,
      'registros': registros,
    };
  }
}

class RegistroDeNota {
  final String alunoID;
  final int nota;
  final String comentario;

  const RegistroDeNota({
    required this.alunoID,
    required this.nota,
    required this.comentario,
  });

  factory RegistroDeNota.fromMap(Map<String, dynamic> map) {
    return RegistroDeNota(
      alunoID: map['alunoID'],
      nota: map['nota'],
      comentario: map['comentario'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alunoID': alunoID,
      'nota': nota,
      'comentario': comentario,
    };
  }
}