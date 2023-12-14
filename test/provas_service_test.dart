import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ost/models/prova_agendada.dart';
import 'package:ost/services/firebase_service.dart';
import 'package:ost/services/provas_service.dart';

class MockFirebaseService extends Mock implements FirebaseService {}

void main() {
  group('Provas Service Tests', () {
    MockFirebaseService mockFirebaseService = MockFirebaseService();
    ProvasService provasService = ProvasService();

    setUp(() {
      mockFirebaseService = MockFirebaseService();
      provasService = ProvasService();
      provasService._firebase = mockFirebaseService;
    });

    test('Test createProvaAgendada', () async {
      // Arrange
      String titulo = 'Teste';
      String descricao = 'Descrição do teste';
      int bimestre = 1;
      DateTime dataAplicacao = DateTime.now();
      String disciplinaID = 'disciplinaID';
      String professorID = 'professorID';
      String turmaID = 'turmaID';
      String provaAgendadaID = '$titulo-$turmaID';
      ProvaAgendadaEntity prova = ProvaAgendadaEntity(
        titulo: titulo,
        descricao: descricao,
        bimestre: bimestre,
        dataAplicacao: dataAplicacao,
        professorID: professorID,
        disciplinaID: disciplinaID,
        turmaID: turmaID,
      );

      // Act
      await provasService.createProvaAgendada(
        titulo: titulo,
        descricao: descricao,
        bimestre: bimestre,
        dataAplicacao: dataAplicacao,
        disciplinaID: disciplinaID,
        professorID: professorID,
        turmaID: turmaID,
      );

      // Assert
      verify(mockFirebaseService.db.collection("provasAgendadas").doc(provaAgendadaID).set(prova.toMap()));
      verify(mockFirebaseService.db.collection("notaProva").doc(provaAgendadaID).set(any));
    });

    test('Test getAllByTurma', () async {
      // Arrange
      String nomeTurma = 'Turma A';
      QuerySnapshot querySnapshot = QuerySnapshot();
      when(mockFirebaseService.db.collection("provasAgendadas").where("turmaID", isEqualTo: nomeTurma).get())
          .thenAnswer((_) async => querySnapshot);

      // Act
      List<ProvaAgendadaEntity> result = await provasService.getAllByTurma(nomeTurma: nomeTurma);

      // Assert
      expect(result, isEmpty);
      verify(mockFirebaseService.db.collection("provasAgendadas").where("turmaID", isEqualTo: nomeTurma).get());
    });

    test('Test atribuirNotaDeProva', () async {
      // Arrange
      String provaID = 'provaID';
      String alunoID = 'alunoID';
      String professorID = 'professorID';
      int nota = 10;
      String comentario = 'Comentário';
      RegistroDeNota registroNota = RegistroDeNota(alunoID: alunoID, nota: nota, comentario: comentario);
      NotaProvaEntity notaProva = NotaProvaEntity(provaID: provaID, professorID: professorID, registros: [registroNota]);

      // Act
      await provasService.atribuirNotaDeProva(
        provaID: provaID,
        alunoID: alunoID,
        professorID: professorID,
        nota: nota,
        comentario: comentario,
      );

      // Assert
      verify(mockFirebaseService.db.collection("notaProva").doc(provaID).update(notaProva.toMap()));
    });

    test('Test getMediaNotasDaDisciplinaBimestre', () async {
      // Arrange
      String alunoID = 'alunoID';
      String disciplinaID = 'disciplinaID';
      int bimestre = 1;
      QuerySnapshot querySnapshot = QuerySnapshot();
      when(mockFirebaseService.db.collection("notaProva")
              .where("alunoID", isEqualTo: alunoID)
              .where("disciplinaID", isEqualTo: disciplinaID)
              .where("bimestre", isEqualTo: bimestre)
              .get())
          .thenAnswer((_) async => querySnapshot);

      // Act
      double result = await provasService.getMediaNotasDaDisciplinaBimestre(
        alunoID: alunoID,
        disciplinaID: disciplinaID,
        bimestre: bimestre,
      );

      // Assert
      expect(result, equals(0));
      verify(mockFirebaseService.db.collection("notaProva")
          .where("alunoID", isEqualTo: alunoID)
          .where("disciplinaID", isEqualTo: disciplinaID)
          .where("bimestre", isEqualTo: bimestre)
          .get());
    });
  });
}