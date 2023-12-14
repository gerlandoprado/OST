import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ost/models/user_data.dart';
import 'package:ost/services/firebase_service.dart';
import 'package:ost/services/user_data_service.dart';

class MockFirebaseService extends Mock implements FirebaseService {}

void main() {
  group('User Data Service Tests', () {
    MockFirebaseService mockFirebaseService = MockFirebaseService();
    UserDataService userDataService = UserDataService();

    setUp(() {
      mockFirebaseService = MockFirebaseService();
      userDataService = UserDataService();
      // BEGIN: ed8c6549bwf9
      userDataService.firebase = mockFirebaseService;
      // END: ed8c6549bwf9
    });
  });
}
      userDataService.firebase = mockFirebaseService;
    });

    test('Test setting current user personal data', () async {
      // Arrange
      String uid = 'test_uid';
      String primeiroNome = 'John';
      String sobrenome = 'Doe';
      String cpf = '123456789';
      String phoneNumber = '1234567890';
      String avatarURL = 'https://example.com/avatar.png';
      String role = 'user';

      UserData userData = UserData(
        primeiroNome: primeiroNome,
        sobrenome: sobrenome,
        cpf: cpf,
        avatarURL: avatarURL,
        telefone: phoneNumber,
        role: role,
      );

      when(mockFirebaseService.db.collection("usuarioDados")).thenReturn(MockCollectionReference<Map<String, dynamic>>());
      when(MockCollectionReference<Map<String, dynamic>>().doc(uid)).thenReturn(MockDocumentReference<Map<String, dynamic>>());
      when(MockDocumentReference<Map<String, dynamic>>().set(any)).thenAnswer((_) => Future.value());

      // Act
      await userDataService.setCurrentUserPersonalData(
        uid: uid,
        primeiroNome: primeiroNome,
        sobrenome: sobrenome,
        cpf: cpf,
        phoneNumber: phoneNumber,
        avatarURL: avatarURL,
        role: role,
      );

      // Assert
      verify(mockFirebaseService.db.collection("usuarioDados")).called(1);
      verify(MockCollectionReference<Map<String, dynamic>>().doc(uid)).called(1);
      verify(MockDocumentReference<Map<String, dynamic>>().set(userData.toMap())).called(1);
    });

    test('Test getting user ID by CPF', () async {
      // Arrange
      String cpf = '123456789';
      UserData userData = UserData(
        primeiroNome: 'John',
        sobrenome: 'Doe',
        cpf: cpf,
        avatarURL: 'https://example.com/avatar.png',
        telefone: '1234567890',
        role: 'user',
      );

      when(mockFirebaseService.db.collection("usuarioDados")).thenReturn(MockCollectionReference<Map<String, dynamic>>());
      when(MockCollectionReference<Map<String, dynamic>>().where("cpf", isEqualTo: cpf)).thenReturn(MockQuery<Map<String, dynamic>>());
      when(MockQuery<Map<String, dynamic>>().limit(1)).thenReturn(MockQuery<Map<String, dynamic>>());
      when(MockQuery<Map<String, dynamic>>().get()).thenAnswer((_) => Future.value(MockQuerySnapshot<Map<String, dynamic>>()));
      when(MockQuerySnapshot<Map<String, dynamic>>().docs).thenReturn([MockDocumentSnapshot<Map<String, dynamic>>()]);
      when(MockDocumentSnapshot<Map<String, dynamic>>().data()).thenReturn(userData.toMap());

      // Act
      UserData result = await userDataService.getUserIDByCPF(cpf: cpf);

      // Assert
      expect(result, equals(userData));
    });

    test('Test getting user by ID', () async {
      // Arrange
      String uid = 'test_uid';
      UserData userData = UserData(
        primeiroNome: 'John',
        sobrenome: 'Doe',
        cpf: '123456789',
        avatarURL: 'https://example.com/avatar.png',
        telefone: '1234567890',
        role: 'user',
      );

      when(mockFirebaseService.db.collection("usuarioDados")).thenReturn(MockCollectionReference<Map<String, dynamic>>());
      when(MockCollectionReference<Map<String, dynamic>>().doc(uid)).thenReturn(MockDocumentReference<Map<String, dynamic>>());
      when(MockDocumentReference<Map<String, dynamic>>().get()).thenAnswer((_) => Future.value(MockDocumentSnapshot<Map<String, dynamic>>()));
      when(MockDocumentSnapshot<Map<String, dynamic>>().exists).thenReturn(true);
      when(MockDocumentSnapshot<Map<String, dynamic>>().data()).thenReturn(userData.toMap());

      // Act
      UserData result = await userDataService.getUserByID(uid: uid);

      // Assert
      expect(result, equals(userData));
    });
  });
}

class MockCollectionReference<T> extends Mock implements CollectionReference<T> {}

class MockDocumentReference<T> extends Mock implements DocumentReference<T> {}

class MockQuery<T> extends Mock implements Query<T> {}

class MockQuerySnapshot<T> extends Mock implements QuerySnapshot<T> {}

class MockDocumentSnapshot<T> extends Mock implements DocumentSnapshot<T> {}
