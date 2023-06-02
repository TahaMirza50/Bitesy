import 'package:Bitesy/features/restaurant/widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HeaderText Widget Test', (WidgetTester tester) async {
    // Define test data
    const String headerText = 'Hello World';
    final TextStyle textStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    // Build the HeaderText widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeaderText(
            header: headerText,
            textStyle: textStyle,
          ),
        ),
      ),
    );

    // Verify that the HeaderText widget is rendered on the screen
    expect(find.byType(HeaderText), findsOneWidget);

    // Verify that the Text widget with the specified header text and style is rendered
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == headerText &&
            widget.style == textStyle,
      ),
      findsOneWidget,
    );
  });
}
