import 'package:flutter/foundation.dart';

@immutable
class ResponsavelEntity {
  final String uid;
  final String alunoID;

  const ResponsavelEntity({
    required this.uid,
    required this.alunoID,
  });

  factory ResponsavelEntity.fromMap(Map<String, dynamic> map ) {
    return ResponsavelEntity(
      uid: map['uid'],
      alunoID: map['alunoID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'alunoID': alunoID,
    };
  }

  // @override
  // String toString() => 'ResponsavelEntity(alunoID: $alunoID, avatarURL: $avatarURL,cpf: $cpf,phoneNumber: $phoneNumber)';

  // @override
  // bool operator ==(Object other) {
  //   if(identical(this, other)) return true;

  //   return other is ResponsavelEntity && other.alunoID == alunoID && other.avatarURL == avatarURL && other.cpf == cpf && other.phoneNumber == phoneNumber;
  // }

  // @override
  // int get hashCode => alunoID.hashCode ^ avatarURL.hashCode ^ cpf.hashCode ^ phoneNumber.hashCode;


}