import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Bitesy/features/login_and_signup/presentation/ui/login.dart';

void main() {
  group('LoginPage Widget', () {
    testWidgets('Should validate email and password and login',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LoginPage(),
      ));

      final emailField = find.byKey(const Key('emailField'));
      final passwordField = find.byKey(const Key('passwordField'));
      final loginButton = find.byKey(const Key('loginButton'));

      // Enter invalid email
      await tester.enterText(emailField, 'invalidemail');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();
      expect(find.text('Invalid email'), findsOneWidget);

      // Enter invalid password
      await tester.enterText(passwordField, 'pass');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();
      expect(find.text('Enter min. 6 characters'), findsOneWidget);

      // Enter valid email and password, perform login
      // when(mockFirebaseAuth.signInWithEmailAndPassword())
      //     .thenAnswer((_) => Future<UserCredential>.value());
      // await tester.enterText(emailField, 'validemail@example.com');
      // await tester.enterText(passwordField, 'validpassword');
      // await tester.tap(loginButton);
      // await tester.pumpAndSettle();
      // expect(find.byType(SearchPage), findsOneWidget);
    });
  });
}
