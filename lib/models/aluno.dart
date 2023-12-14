import 'package:flutter/foundation.dart';

@immutable
class AlunoEntity {
  final String matricula;
  final Map<String, String> nome;
  final String avatarURL;
  final String dataNascimento;
  final String turmaID;

  const AlunoEntity({
    required this.nome,
    required this.avatarURL,
    required this.matricula,
    required this.dataNascimento,
    required this.turmaID,
  });

  factory AlunoEntity.fromMap(Map<String, dynamic> map) {
    return AlunoEntity(
      nome: map['nome'],
      avatarURL: map['avatarURL'],
      matricula: map['matricula'],
      dataNascimento: map['dataNascimento'],
      turmaID: map['turmaID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'avatarURL': avatarURL,
      'matricula': matricula,
      'dataNascimento': dataNascimento,
      'turmaID': turmaID,
    };
  }
}
