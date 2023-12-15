
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost/services/authentication_service.dart';

// Criando uma classe Mock para simular o FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  group('Serviço de Autenticação', () {
    MockFirebaseAuth mockAuth;
    AuthenticationService service;

    setUp(() {
      mockAuth = MockFirebaseAuth();
      service = AuthenticationService(auth: mockAuth);
    });

    test('Criação de usuário com sucesso', () async {
      when(mockAuth.createUserWithEmailAndPassword(
        email: 'teste@example.com',
        password: 'senha123',
      )).thenAnswer((_) async => MockUserCredential());

      var resultado = await service.createUser(
        email: 'teste@example.com',
        password: 'senha123',
      );

      expect(resultado, isA<AuthStatus>());
      expect(resultado, equals(AuthStatus.success));
    });

    test('Falha na criação de usuário', () async {
      when(mockAuth.createUserWithEmailAndPassword(
        email: 'existente@example.com',
        password: 'senha123',
      )).thenThrow(FirebaseAuthException(
        code: 'email-already-in-use',
        message: 'O email já está em uso.',
      ));

      expect(
        service.createUser(email: 'existente@example.com', password: 'senha123'),
        throwsA(isA<FirebaseAuthException>()),
      );
    });

    // Mais testes podem ser adicionados aqui para signIn e signOut
  });
}
