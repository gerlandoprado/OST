import 'package:flutter/foundation.dart';

@immutable
class AlunoEntity {
  final String uid;
  final Map<String, String> name;
  final String avatarURL;
  final String dataNascimento;
  final String cpf;
  final String matricula;

  const AlunoEntity({
    required this.uid,
    required this.name,
    required this.avatarURL,
    required this.cpf,
    required this.matricula,
    required this.dataNascimento,
  });

  factory AlunoEntity.fromMap(Map<String, dynamic> map ) {
    return AlunoEntity(
      uid: map['uid'],
      name: map['name'],
      avatarURL: map['avatarURL'],
      cpf: map['cpf'],
      matricula: map['matricula'],
      dataNascimento: map['dataNascimento'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'avatarURL': avatarURL,
      'cpf': cpf,
      'matricula': matricula,
      'dataNascimento': dataNascimento,
    };
  }

  // @override
  // String toString() => 'AlunoEntity(name: $name, avatarURL: $avatarURL,cpf: $cpf,phoneNumber: $phoneNumber)';

  // @override
  // bool operator ==(Object other) {
  //   if(identical(this, other)) return true;

  //   return other is AlunoEntity && other.name == name && other.avatarURL == avatarURL && other.cpf == cpf && other.phoneNumber == phoneNumber;
  // }

  // @override
  // int get hashCode => name.hashCode ^ avatarURL.hashCode ^ cpf.hashCode ^ phoneNumber.hashCode;


}