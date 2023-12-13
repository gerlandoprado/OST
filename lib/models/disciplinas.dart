import 'package:flutter/foundation.dart';

@immutable
class DisciplinaEntity {
  final String uid;
  final String nome;
  final List<Map<String, String>> horarioAulas;
  final String sala;
  final String professorID;

  const DisciplinaEntity({
    required this.uid,
    required this.nome,
    required this.horarioAulas,
    required this.sala,
    required this.professorID,
  });

  factory DisciplinaEntity.fromMap(Map<String, dynamic> map ) {
    return DisciplinaEntity(
      uid: map['uid'],
      nome: map['nome'],
      horarioAulas: map['horarioAulas'],
      sala: map['sala'],
      professorID: map['professorID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nome': nome,
      'horarioAulas': horarioAulas,
      'sala': sala,
      'professorID': professorID,
    };
  }
}