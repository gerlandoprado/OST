import 'package:flutter/foundation.dart';

@immutable
class TurmaEntity {
  final String nome;
  final int anoLetivo;
  final String sala;
  final String turno;

  const TurmaEntity({
    required this.nome,
    required this.anoLetivo,
    required this.sala,
    required this.turno,
  });

  factory TurmaEntity.fromMap(Map<String, dynamic> map ) {
    return TurmaEntity(
      nome: map['nome'],
      anoLetivo: map['anoLetivo'],
      sala: map['sala'],
      turno: map['turno'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'anoLetivo': anoLetivo,
      'sala': sala,
      'turno': turno,
    };
  }
}