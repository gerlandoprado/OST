import 'package:flutter/foundation.dart';

@immutable
class UserData {
  final Map<String, String> nome;
  final String avatarURL;
  final String cpf;
  final String telefone;
  final String role;

  const UserData({
    required this.nome,
    required this.avatarURL,
    required this.cpf,
    required this.telefone,
    required this.role,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      nome: map['nome'],
      avatarURL: map['avatarURL'],
      cpf: map['cpf'],
      telefone: map['telefone'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'avatarURL': avatarURL,
      'cpf': cpf,
      'telefone': telefone,
      'role': role,
    };
  }
}
