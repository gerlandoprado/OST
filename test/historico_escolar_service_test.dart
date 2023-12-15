import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ost/models/historico_escolar.dart';
import 'package:ost/services/frequencia_aluno_service.dart';
import 'package:ost/services/historico_escolar_service.dart';
import 'package:ost/services/provas_service.dart';

class MockHistoricoEscolarService extends Mock implements HistoricoEscolarService {}

class MockProvasService extends Mock implements ProvasService {}

class MockFrequenciaAlunoService extends Mock implements FrequenciaAlunoService {}

void main() {
  group('Historico Escolar Service Tests', () {
    late MockHistoricoEscolarService mockHistoricoEscolarService;
    late MockProvasService mockProvasService;
    late MockFrequenciaAlunoService mockFrequenciaAlunoService;

    setUp(() {
      mockHistoricoEscolarService = MockHistoricoEscolarService();
      mockProvasService = MockProvasService();
      mockFrequenciaAlunoService = MockFrequenciaAlunoService();
    });

    test('Test createHistoricoEscolar', () async {
      // Arrange
      final alunoID = 'alunoID';
      final anoLetivo = 2022;
      final turmaID = 'turmaID';
      final disciplinas = <Disciplina>[];

      // Act
      await mockHistoricoEscolarService.createHistoricoEscolar(
        alunoID: alunoID,
        anoLetivo: anoLetivo,
        turmaID: turmaID,
        disciplinas: disciplinas,
      );

      // Assert
      verify(mockHistoricoEscolarService.createHistoricoEscolar(
        alunoID: alunoID,
        anoLetivo: anoLetivo,
        turmaID: turmaID,
        disciplinas: disciplinas,
      )).called(1);
    });

    test('Test adicionarMediaEFaltasBimestreNaDisciplina', () async {
      // Arrange
      final alunoID = 'alunoID';
      final anoLetivo = 2022;
      final turmaID = 'turmaID';
      final disciplinaID = 'disciplinaID';
      final bimestre = 1;

      // Act
      await mockHistoricoEscolarService.adicionarMediaEFaltasBimestreNaDisciplina(
        alunoID: alunoID,
        anoLetivo: anoLetivo,
        turmaID: turmaID,
        disciplinaID: disciplinaID,
        bimestre: bimestre,
      );

      // Assert
      verify(mockHistoricoEscolarService.adicionarMediaEFaltasBimestreNaDisciplina(
        alunoID: alunoID,
        anoLetivo: anoLetivo,
        turmaID: turmaID,
        disciplinaID: disciplinaID,
        bimestre: bimestre,
      )).called(1);
    });

    test('Test getHistoricoEscolarDeAluno', () async {
      // Arrange
      final alunoID = 'alunoID';
      final anoLetivo = 2022;
      final turmaID = 'turmaID';
      final historicoEscolarEntity = HistoricoEscolarEntity();

      // Act
      when(mockHistoricoEscolarService.getHistoricoEscolarDeAluno(
        alunoID: alunoID,
        anoLetivo: anoLetivo,
        turmaID: turmaID,
      )).thenAnswer((_) async => historicoEscolarEntity);

      final result = await mockHistoricoEscolarService.getHistoricoEscolarDeAluno(
        alunoID: alunoID,
        anoLetivo: anoLetivo,
        turmaID: turmaID,
      );

      // Assert
      expect(result, historicoEscolarEntity);
      verify(mockHistoricoEscolarService.getHistoricoEscolarDeAluno(
        alunoID: alunoID,
        anoLetivo: anoLetivo,
        turmaID: turmaID,
      )).called(1);
    });
  });
}