import 'package:flutter/foundation.dart';

@immutable
class ResponsavelEntity {
  final String alunoID;
  final bool alunoFoiVinculado;

  const ResponsavelEntity({
    required this.alunoID,
    required this.alunoFoiVinculado,
  });

  factory ResponsavelEntity.fromMap(Map<String, dynamic> map) {
    return ResponsavelEntity(
      alunoID: map['alunoID'],
      alunoFoiVinculado: map['alunoFoiVinculado'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alunoID': alunoID,
      'alunoFoiVinculado': alunoFoiVinculado,
    };
  }
}
