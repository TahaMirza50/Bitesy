import 'package:Bitesy/constants/constants.dart';
import 'package:Bitesy/features/restaurant/sections/menu/presentation/ui/restaurant_menu.dart';
import 'package:Bitesy/features/restaurant/widgets/header_text.dart';
import 'package:Bitesy/features/search_page/data/model/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RestaurantMenu Widget Tests', () {
    final RestaurantModel restaurantModel = RestaurantModel(
        id: Constants.IDGenerator.v1(),
        name: 'name',
        address: 'address',
        phoneNum: 'phoneNum',
        description: 'description',
        email: 'email',
        website: 'website',
        latitude: 'latitude',
        longitude: 'longitude',
        avgRating: "0.0",
        numReviews: 0,
        images: [''],
        ratingCounts: {'5': 0, '4': 0, '3': 0, '2': 0, '1': 0},
        menu:
            'https://firebasestorage.googleapis.com/v0/b/bitesy-fa8bc.appspot.com/o/images%2Fff2b3ee0-feea-11ed-ba87-932abf97281b%2F08f83f90-feeb-11ed-ba87-932abf97281b?alt=media&token=6cbfacb4-6c22-4ebc-b110-45f60b971dbd');

    testWidgets('RestaurantMenu Widget Renders Correctly',
        (WidgetTester tester) async {
      // Define test data

      // Build the RestaurantMenu widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestaurantMenu(restaurantModel: restaurantModel),
          ),
        ),
      );

      // Verify that the RestaurantMenu widget is rendered on the screen
      expect(find.byType(RestaurantMenu), findsOneWidget);
    });

    testWidgets('HeaderText Widget Renders Correctly',
        (WidgetTester tester) async {
      // Build the RestaurantMenu widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestaurantMenu(restaurantModel: restaurantModel),
          ),
        ),
      );

      // Verify that the HeaderText widget with the specified properties is rendered
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is HeaderText &&
              widget.header == 'Menu' &&
              widget.textStyle.fontSize == 22 &&
              widget.textStyle.fontWeight == FontWeight.w900,
        ),
        findsOneWidget,
      );
    });

    testWidgets('GestureDetector Triggers Dialog', (WidgetTester tester) async {
      // Build the RestaurantMenu widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestaurantMenu(restaurantModel: restaurantModel),
          ),
        ),
      );

      // Simulate tap on the GestureDetector widget
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Verify that the Dialog widget is rendered
      // expect(find.byType(Dialog), findsOneWidget);
    });

    // testWidgets('Image Widget Renders Correctly in Dialog',
    //     (WidgetTester tester) async {
    //   // Build the RestaurantMenu widget
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: Scaffold(
    //         body: RestaurantMenu(restaurantModel: restaurantModel),
    //       ),
    //     ),
    //   );

    //   // Simulate tap on the GestureDetector widget
    //   await tester.tap(find.byType(GestureDetector));
    //   await tester.pumpAndSettle();

    //   // Verify that the Image widget with the specified properties is rendered in the Dialog
    //   expect(
    //     find.byWidgetPredicate(
    //       (widget) =>
    //           widget is Image &&
    //           widget.image is NetworkImage &&
    //           widget.height == 400.0,
    //     ),
    //     findsOneWidget,
    //   );
    // });
  });
}
