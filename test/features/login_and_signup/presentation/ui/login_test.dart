import 'package:Bitesy/features/search_page/presentation/ui/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Bitesy/features/login_and_signup/presentation/ui/login.dart';
import 'package:mockito/mockito.dart';


void main() {
  group('LoginPage Widget', () {

    testWidgets('Login page displays correctly', (WidgetTester tester) async {

        await tester.pumpWidget(MaterialApp(home: LoginPage()));

        expect(find.text("Welcome Back!"), findsOneWidget);
        expect(find.text("Enter your credentials to continue"), findsOneWidget);
        expect(find.byType(TextFormField), findsNWidgets(2));
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.byIcon(Icons.mail), findsOneWidget);
        expect(find.byIcon(Icons.lock), findsOneWidget);
      // Build the widget
    });

    testWidgets('Should validate email and password',
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

    });
  });
}
