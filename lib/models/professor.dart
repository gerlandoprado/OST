import 'package:flutter/foundation.dart';

@immutable
class ProfessorEntity {
  final String uid;
  final String graduation;
  final bool accountAproved;

  const ProfessorEntity({
    required this.uid,
    required this.graduation,
    required this.accountAproved,
  });

  factory ProfessorEntity.fromMap(Map<String, dynamic> map ) {
    return ProfessorEntity(
      uid: map['uid'],
      graduation: map['graduation'],
      accountAproved: map['accountAproved'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'graduation': graduation,
      'accountAproved': accountAproved,
    };
  }
}