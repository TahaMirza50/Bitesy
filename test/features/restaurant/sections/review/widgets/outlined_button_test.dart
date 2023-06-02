import 'package:Bitesy/features/restaurant/sections/review/widgets/outlined_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('ReviewOutlinedButton renders correctly when disabled', (WidgetTester tester) async {
    const String label = 'Add Photo';
    const IconData icon = Icons.camera_alt_outlined;
    bool disabled = true;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ReviewOutlinedButton(
            label: label,
            icon: icon,
            onPressed: null
          ),
        ),
      ),
    );

    // Verify that the button is rendered correctly
    expect(find.text(label), findsOneWidget);
    expect(find.byIcon(icon), findsOneWidget);

    // Verify that the onPressed callback is triggered when the button is tapped
    await tester.tap(find.text(label));
    await tester.pumpAndSettle();

    expect(disabled, true);
  });

    testWidgets('ReviewOutlinedButton renders correctly', (WidgetTester tester) async {
    const String label = 'Add Photo';
    const IconData icon = Icons.camera_alt_outlined;
    bool onPressedCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ReviewOutlinedButton(
            label: label,
            icon: icon,
            onPressed: () {
              onPressedCalled = true;
              return Future.value(); // Return a Future<void> value
            },
          ),
        ),
      ),
    );

    // Verify that the button is rendered correctly
    expect(find.text(label), findsOneWidget);
    expect(find.byIcon(icon), findsOneWidget);

    // Verify that the onPressed callback is triggered when the button is tapped
    await tester.tap(find.text(label));
    await tester.pumpAndSettle();

    expect(onPressedCalled, true);
  });
}
