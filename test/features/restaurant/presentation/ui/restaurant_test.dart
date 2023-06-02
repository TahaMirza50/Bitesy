import 'package:Bitesy/features/restaurant/presentation/ui/restaurant.dart';
import 'package:Bitesy/features/restaurant/sections/info/presentation/ui/restaurant_info.dart';
import 'package:Bitesy/features/restaurant/sections/menu/presentation/ui/restaurant_menu.dart';
import 'package:Bitesy/features/restaurant/sections/review/presentation/ui/restaurant_review.dart';
import 'package:Bitesy/features/search_page/data/model/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RestaurantPage', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });
    final restaurantModel = RestaurantModel(
        id: '1',
        description: "Test Restaurant Description",
        email: "test@gmail.com",
        menu: "https://www.testrestaurant.com/menu.jpg",
        name: 'Test Restaurant',
        phoneNum: '1234567890',
        website: 'https://www.testrestaurant.com',
        address: '123 Test St',
        images: ['https://www.testrestaurant.com/image1.jpg'],
        latitude: "24.904519",
        longitude: "67.077975",
        avgRating: '4.5',
        numReviews: 10,
        ratingCounts: {
          "5": 5,
          "4": 3,
          "3": 1,
          "2": 0,
          "1": 1,
        });
    testWidgets('should render website icon button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(home: RestaurantPage(restaurantModel: restaurantModel)));

      expect(find.byIcon(Icons.link_outlined), findsOneWidget);
    });

    testWidgets('should render map icon button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(home: RestaurantPage(restaurantModel: restaurantModel)));

      expect(find.byIcon(Icons.map_outlined), findsOneWidget);
    });

    testWidgets('should render call icon button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(home: RestaurantPage(restaurantModel: restaurantModel)));

      expect(find.byIcon(Icons.call_outlined), findsOneWidget);
    });

    testWidgets('should render menu, info, and review sections',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(home: RestaurantPage(restaurantModel: restaurantModel)));

      expect(find.byType(RestaurantMenu), findsOneWidget);
      expect(find.byType(RestaurantInfo), findsOneWidget);
      expect(find.byType(RestaurantReview), findsOneWidget);
    });
  });
}
