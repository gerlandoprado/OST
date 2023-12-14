import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ost/models/turmas.dart';
import 'package:ost/services/firebase_service.dart';
import 'package:ost/services/turmas_service.dart';

class MockFirebaseService extends Mock implements FirebaseService {}

void main() {
  group('Turmas Service Tests', () {
    MockFirebaseService mockFirebaseService = MockFirebaseService();
    TurmasService turmasService = TurmasService();

    setUp(() {
      mockFirebaseService = MockFirebaseService();
      turmasService = TurmasService();
      turmasService._firebase = mockFirebaseService;
    });

    test('Test createTurma method', () async {
      // Arrange
      String nome = 'Turma A';
      String sala = 'Sala 101';
      int anoLetivo = 2022;
      String turno = 'Manhã';
      TurmaEntity turma = TurmaEntity(nome: nome, sala: sala, anoLetivo: anoLetivo, turno: turno);

      // Act
      await turmasService.createTurma(nome: nome, sala: sala, anoLetivo: anoLetivo, turno: turno);

      // Assert
      verify(mockFirebaseService.db.collection('turmas').doc(nome).set(turma.toMap()));
    });

    test('Test getTurmaByName method - document exists', () async {
      // Arrange
      String nome = 'Turma A';
      TurmaEntity turma = TurmaEntity(nome: nome, sala: 'Sala 101', anoLetivo: 2022, turno: 'Manhã');
      when(mockFirebaseService.db.collection('turmas').doc(nome).get())
          .thenAnswer((_) async => DocumentSnapshotMock(data: turma.toMap(), exists: true));

      // Act
      TurmaEntity result = await turmasService.getTurmaByName(nome: nome);

      // Assert
      expect(result, turma);
    });

    test('Test getTurmaByName method - document does not exist', () async {
      // Arrange
      String nome = 'Turma A';
      when(mockFirebaseService.db.collection('turmas').doc(nome).get())
          .thenAnswer((_) async => DocumentSnapshotMock(data: null, exists: false));

      // Act & Assert
      expect(() => turmasService.getTurmaByName(nome: nome), throwsA(isA<StateError>()));
    });
  });
}

class DocumentSnapshotMock extends Mock implements DocumentSnapshot {
  final Map<String, dynamic>? data;
  final bool exists;

  DocumentSnapshotMock({this.data, required this.exists});

  @override
  Map<String, dynamic>? get data => data;

  @override
  bool get exists => exists;
}