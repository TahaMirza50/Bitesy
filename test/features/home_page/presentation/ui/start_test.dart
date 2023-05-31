import 'package:Bitesy/features/home_page/presentation/ui/start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

void main() {

  group('HomePage Widget', () {
    testWidgets('renders title and slogan', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );

      // Verify the presence of the login and sign up buttons
      expect(find.text('Bitesy'), findsOneWidget);
      expect(find.text('Explore Restaurants all around you'), findsOneWidget);
    });

    testWidgets('renders login and sign up buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );

      // Verify the presence of the login and sign up buttons
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });

  });
}