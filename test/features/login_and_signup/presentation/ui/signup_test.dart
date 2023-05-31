import 'package:Bitesy/features/login_and_signup/presentation/ui/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  group('SignUpPage Widget Tests', () {
    testWidgets('Sign Up page displays correctly', (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(MaterialApp(home: SignUpPage()));

        // Verify that the Sign Up page is displayed correctly
        expect(find.text('Sign Up'), findsNWidgets(2));
        expect(find.text('Create Account'), findsOneWidget);
        expect(find.text('Sign Up to get started.'), findsOneWidget);
        expect(find.byType(TextFormField), findsNWidgets(5));
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.byIcon(Icons.mail), findsOneWidget);
        expect(find.byIcon(Icons.lock), findsNWidgets(2));
        expect(find.byIcon(Icons.person), findsNWidgets(2));
        expect(find.byIcon(Icons.male_rounded), findsOneWidget);
        expect(find.byIcon(Icons.male_rounded), findsOneWidget);
      });
      // Build the widget
    });
  });

  testWidgets('Should validate email and password and login',
      (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(MaterialApp(home: SignUpPage()));

      final firstName = find.byKey(const Key('firstName'));
      final lastName = find.byKey(const Key('lastName'));
      final email = find.byKey(const Key('email'));
      final password1 = find.byKey(const Key('password1'));
      final password2 = find.byKey(const Key('password2'));
      final signUp = find.widgetWithText(ElevatedButton, 'Sign Up');

      //Enter invalid name
      await tester.enterText(firstName, 'Hello');
      await tester.enterText(firstName, '');
      await tester.ensureVisible(signUp);
      await tester.tap(signUp);
      await tester.pumpAndSettle();
      expect(find.text('Enter first name.'), findsOneWidget);

      //Enter invalid name
      await tester.enterText(lastName, 'Hello');
      await tester.enterText(lastName, '');
      await tester.ensureVisible(signUp);
      await tester.tap(signUp);
      await tester.pumpAndSettle();
      expect(find.text('Enter last name.'), findsOneWidget);

      // Enter invalid email
      await tester.enterText(email, 'invalidemail');
      await tester.ensureVisible(signUp);
      await tester.tap(signUp);
      await tester.pumpAndSettle();
      expect(find.text('Invalid email'), findsOneWidget);

      // Enter invalid password
      await tester.enterText(password1, 'pass');
      await tester.ensureVisible(signUp);
      await tester.tap(signUp);
      await tester.pumpAndSettle();
      expect(find.text('Enter min. 6 characters'), findsOneWidget);

      // Enter invalid confirm password
      await tester.enterText(password1, 'myPassword');
      await tester.enterText(password2, 'Password');
      await tester.ensureVisible(signUp);
      await tester.tap(signUp);
      await tester.pumpAndSettle();
      expect(find.text('Password does not match'), findsOneWidget);
    });
  });

  // Add more test cases as needed
}
