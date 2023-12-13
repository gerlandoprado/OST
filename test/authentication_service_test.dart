import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ost/main.dart';
import 'package:ost/services/authentication_service.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  group('Authentication Service Tests', () {
    MockFirebaseAuth mockFirebaseAuth;
    AuthenticationService authenticationService;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      authenticationService = AuthenticationService(auth: mockFirebaseAuth);
    });

    test('Test authentication service initialization', () {
      expect(authenticationService.auth, mockFirebaseAuth);
    });
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
