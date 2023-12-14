import 'package:flutter/foundation.dart';

@immutable
class UserData {
  final String primeiroNome;
  final String sobrenome;
  final String avatarURL;
  final String cpf;
  final String telefone;
  final String role;

  const UserData({
    required this.primeiroNome,
    required this.sobrenome,
    required this.avatarURL,
    required this.cpf,
    required this.telefone,
    required this.role,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      primeiroNome: map['primeiroNome'],
      sobrenome: map['sobrenome'],
      avatarURL: map['avatarURL'],
      cpf: map['cpf'],
      telefone: map['telefone'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'primeiroNome': primeiroNome,
      'sobrenome': sobrenome,
      'avatarURL': avatarURL,
      'cpf': cpf,
      'telefone': telefone,
      'role': role,
    };
  }
}
