import 'package:flutter/foundation.dart';

@immutable
class AlunoEntity {
  final String matricula;
  final Map<String, String> name;
  final String avatarURL;
  final String cpf;
  final String dataNascimento;
  final String turmaID;

  const AlunoEntity({
    required this.name,
    required this.avatarURL,
    required this.cpf,
    required this.matricula,
    required this.dataNascimento,
    required this.turmaID,
  });

  factory AlunoEntity.fromMap(Map<String, dynamic> map ) {
    return AlunoEntity(
      name: map['name'],
      avatarURL: map['avatarURL'],
      cpf: map['cpf'],
      matricula: map['matricula'],
      dataNascimento: map['dataNascimento'],
      turmaID: map['turmaID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'avatarURL': avatarURL,
      'cpf': cpf,
      'matricula': matricula,
      'dataNascimento': dataNascimento,
      'turmaID': turmaID,
    };
  }

}