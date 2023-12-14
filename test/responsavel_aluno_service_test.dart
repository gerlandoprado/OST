import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ost/models/user_data.dart';
import 'package:ost/services/authentication_service.dart';
import 'package:ost/services/firebase_service.dart';
import 'package:ost/services/responsavel_aluno_service.dart';
import 'package:ost/services/user_data_service.dart';

class MockFirebaseService extends Mock implements FirebaseService {}

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUserDataService extends Mock implements UserDataService {}

void main() {
  group('ResponsavelAlunoService Tests', () {
    late ResponsavelAlunoService responsavelAlunoService;
    late MockFirebaseService mockFirebaseService;
    late MockAuthenticationService mockAuthenticationService;
    late MockUserDataService mockUserDataService;

    setUp(() {
      mockFirebaseService = MockFirebaseService();
      mockAuthenticationService = MockAuthenticationService();
      mockUserDataService = MockUserDataService();
      responsavelAlunoService = ResponsavelAlunoService();
      responsavelAlunoService._firebase = mockFirebaseService;
      responsavelAlunoService.authService = mockAuthenticationService;
    });

    test('Test createResponsavel', () async {
      // Arrange
      const String uid = 'test_uid';
      const String primeiroNome = 'John';
      const String sobrenome = 'Doe';
      const String email = 'john.doe@example.com';
      const String password = 'password';
      const String cpf = '123456789';
      const String phoneNumber = '1234567890';
      const String avatarURL = 'https://example.com/avatar.jpg';

      final currentUser = MockUser();
      when(mockFirebaseService.auth.currentUser).thenReturn(currentUser);
      when(currentUser.uid).thenReturn(uid);

      // Act
      await responsavelAlunoService.createResponsavel(
        uid: uid,
        primeiroNome: primeiroNome,
        sobrenome: sobrenome,
        email: email,
        password: password,
        cpf: cpf,
        phoneNumber: phoneNumber,
        avatarURL: avatarURL,
      );

      // Assert
      verify(mockUserDataService.setCurrentUserPersonalData(
        uid: uid,
        primeiroNome: primeiroNome,
        sobrenome: sobrenome,
        cpf: cpf,
        phoneNumber: phoneNumber,
        avatarURL: avatarURL,
        role: 'responsavel',
      )).called(1);

      verify(mockFirebaseService.db.collection('responsavel').doc(uid).set(any)).called(1);
    });

    test('Test createAluno', () async {
      // Arrange
      const String primeiroNome = 'John';
      const String sobrenome = 'Doe';
      const String dataNascimento = '2000-01-01';
      const String escolaNome = 'Example School';
      const String avatarURL = 'https://example.com/avatar.jpg';
      const String alunoMatricula = '123456';

      // Act
      await responsavelAlunoService.createAluno(
        primeiroNome: primeiroNome,
        sobrenome: sobrenome,
        dataNascimento: dataNascimento,
        escolaNome: escolaNome,
        avatarURL: avatarURL,
        alunoMatricula: alunoMatricula,
      );

      // Assert
      verify(mockFirebaseService.db.collection('aluno').doc(alunoMatricula).set(any)).called(1);
    });

    test('Test vincularResponsavelAluno', () async {
      // Arrange
      const String responsavelID = 'test_responsavel_id';
      const String alunoMatricula = 'test_aluno_matricula';

      // Act
      await responsavelAlunoService.vincularResponsavelAluno(
        responsavelID: responsavelID,
        alunoMatricula: alunoMatricula,
      );

      // Assert
      verify(mockFirebaseService.db.collection('responsavel').doc(responsavelID).update(any)).called(1);
    });

    test('Test listeResponsaveisNaoVinculados', () async {
      // Arrange
      final mockQuerySnapshot = MockQuerySnapshot();
      final mockDocSnapshot = MockQueryDocumentSnapshot();
      final mockUserData = UserData();
      when(mockFirebaseService.db.collection('responsavel')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('alunoFoiVinculado', isEqualTo: false)).thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockDocSnapshot]);
      when(mockDocSnapshot.exists).thenReturn(true);
      when(mockDocSnapshot.id).thenReturn('test_uid');
      when(mockUserDataService.getUserByID(uid: anyNamed('uid'))).thenAnswer((_) async => mockUserData);

      // Act
      final result = await responsavelAlunoService.listeResponsaveisNaoVinculados();

      // Assert
      expect(result, [mockUserData]);
    });
  });
}