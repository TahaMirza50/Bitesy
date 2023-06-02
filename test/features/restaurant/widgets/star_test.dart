import 'package:Bitesy/features/restaurant/widgets/star.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Star Widget Test', (WidgetTester tester) async {
    // Build the Star widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Star(
            width: 100,
            height: 100,
            color: Colors.blue,
            starSize: 50,
          ),
        ),
      ),
    );

    // Verify that the Star widget is rendered on the screen
    expect(find.byType(Star), findsOneWidget);

    // Verify that the Icon widget with the specified properties is rendered
    expect(
      find.byWidgetPredicate((widget) =>
          widget is Icon &&
          widget.icon == Icons.star_rounded &&
          widget.color == Colors.white &&
          widget.size == 50),
      findsOneWidget,
    );
  });
}