import 'package:flutter/foundation.dart';

@immutable
class UserData {
  final String uid;
  final Map name;
  final String avatarURL; 
  final String cpf;
  final String phoneNumber;

  const UserData({
    required this.uid,
    required this.name,
    required this.avatarURL,
    required this.cpf,
    required this.phoneNumber,
  });

  factory UserData.fromMap(Map<String, dynamic> map ) {
    return UserData(
      uid: map['uid'],
      name: map['name'],
      avatarURL: map['avatarURL'],
      cpf: map['cpf'],
      phoneNumber: map['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'avatarURL': avatarURL,
      'cpf': cpf,
      'phoneNumber': phoneNumber,
    };
  }

  // @override
  // String toString() => 'UserData(name: $name, avatarURL: $avatarURL,cpf: $cpf,phoneNumber: $phoneNumber)';

  // @override
  // bool operator ==(Object other) {
  //   if(identical(this, other)) return true;

  //   return other is UserData && other.name == name && other.avatarURL == avatarURL && other.cpf == cpf && other.phoneNumber == phoneNumber;
  // }

  // @override
  // int get hashCode => name.hashCode ^ avatarURL.hashCode ^ cpf.hashCode ^ phoneNumber.hashCode;


}