import 'package:Bitesy/constants/constants.dart';
import 'package:Bitesy/features/restaurant/sections/info/presentation/ui/restaurant_info.dart';
import 'package:Bitesy/features/search_page/data/model/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Bitesy/features/restaurant/widgets/header_text.dart';

void main() {
  group('RestaurantInfo Widget Tests', () {
    final RestaurantModel restaurantModel = RestaurantModel(
        id: Constants.IDGenerator.v1(),
        name: 'name',
        address: 'address',
        phoneNum: '+1234567891',
        description: 'description',
        email: 'email',
        website: 'website',
        latitude: '37.7749',
        longitude: '-122.4194',
        avgRating: "0.0",
        numReviews: 0,
        images: [''],
        ratingCounts: {'5': 0, '4': 0, '3': 0, '2': 0, '1': 0},
        menu: '');

    testWidgets('RestaurantInfo Widget Renders Correctly',
        (WidgetTester tester) async {
      // Build the RestaurantInfo widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestaurantInfo(restaurantModel: restaurantModel),
          ),
        ),
      );

      // Verify that the RestaurantInfo widget is rendered on the screen
      expect(find.byType(RestaurantInfo), findsOneWidget);
    });

    testWidgets('HeaderText Widget Renders Correctly',
        (WidgetTester tester) async {
      // Build the RestaurantInfo widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestaurantInfo(restaurantModel: restaurantModel),
          ),
        ),
      );

      // Verify that the HeaderText widget with the specified properties is rendered
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is HeaderText &&
              widget.header == 'Info' &&
              widget.textStyle.fontSize == 22 &&
              widget.textStyle.fontWeight == FontWeight.w900,
        ),
        findsOneWidget,
      );
    });

    // testWidgets('Info Tab Renders Correctly', (WidgetTester tester) async {
    //   // Build the RestaurantInfo widget
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: Scaffold(
    //         body: RestaurantInfo(restaurantModel: restaurantModel),
    //       ),
    //     ),
    //   );

    //   // Verify that the info tabs with the specified headers are rendered
    //   expect(
    //     find.byWidgetPredicate(
    //       (widget) =>
    //           widget is Row &&
    //               widget.children.length == 2 &&
    //               widget.children[0] is Column &&
    //               widget.children[1] is Icon &&
    //               (widget.children[0] as Column).children[0] is HeaderText &&
    //       ((widget.children[0] as Column).children[0] as HeaderText).header ==
    //               'Website' &&
    //           (widget.children[0] as Column).children[1] is HeaderText &&
    //           ((widget.children[0] as Column).children[1] as HeaderText)
    //                   .header ==
    //               'Call',
    //     ),
    //     findsNWidgets(2), // Assuming there are two info tabs
    //   );
    // });

    testWidgets('GoogleMap Renders Correctly', (WidgetTester tester) async {
      // Build the RestaurantInfo widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestaurantInfo(restaurantModel: restaurantModel),
          ),
        ),
      );

      // Verify that the GoogleMap widget is rendered
      expect(find.byType(GoogleMap), findsOneWidget);
    });

    testWidgets('Get Directions Button Triggers openGoogleMaps',
        (WidgetTester tester) async {
      // Build the RestaurantInfo widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestaurantInfo(restaurantModel: restaurantModel),
          ),
        ),
      );

      // Simulate tap on the Get Directions button
      await tester.tap(find.text('Get Directions'));
      await tester.pumpAndSettle();
    });

  //   testWidgets('Address Info Renders Correctly', (WidgetTester tester) async {
  //     // Build the RestaurantInfo widget
  //     await tester.pumpWidget(
  //       MaterialApp(
  //         home: Scaffold(
  //           body: RestaurantInfo(restaurantModel: restaurantModel),
  //         ),
  //       ),
  //     );

  //     // Verify that the address info with the specified properties is rendered
  //     expect(
  //       find.byWidgetPredicate(
  //         (widget) =>
  //             widget is Column &&
  //             widget.children.length == 2 &&
  //             widget.children[0] is HeaderText &&
  //             widget.children[1] is SizedBox,
  //       ),
  //       findsOneWidget,
  //     );
  //   });
  });
}
