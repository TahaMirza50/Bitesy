import 'package:Bitesy/features/restaurant/sections/write_a_review/presentation/widgets/star_select.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('StarSelect updates starsSelected correctly', (WidgetTester tester) async {
    int starsSelected = 3;

    // Build the StarSelect widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StarSelect(
            setStarsSelected: (value) {
              starsSelected = value;
            },
            starsSelected: starsSelected,
          ),
        ),
      ),
    );

    // Verify the initial starsSelected value
    expect(starsSelected, 3);

    // Tap on the fourth star
    await tester.tap(find.byKey(Key('4')));
    await tester.pump();

    // Verify that starsSelected is updated to 4
    expect(starsSelected, 4);

    // Tap on the second star
    await tester.tap(find.byKey(Key('2')));
    await tester.pump();

    // Verify that starsSelected is updated to 2
    expect(starsSelected, 2);
  });
}
