import 'package:Bitesy/features/admin_page/presentation/ui/add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('Testing admin page', () {
    testWidgets('add page check for texts', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AddRestaurantPage()));

      await tester.pumpAndSettle();

      expect(find.text('Add Restaurant'), findsNWidgets(2));
      expect(find.text('Enter Restaurant Information'), findsOneWidget);
      expect(find.text('Enter Restaurant Images'), findsOneWidget);
      expect(find.text('Enter Menu Images'), findsOneWidget);
      expect(find.text('Select Location'), findsOneWidget);
      expect(find.text('Check Address'), findsOneWidget);
    });

    testWidgets('add page should render correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AddRestaurantPage()));

      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(8));
      expect(find.byType(ElevatedButton), findsNWidgets(2));
      expect(find.byIcon(Icons.clear), findsNWidgets(7));
      expect(find.byIcon(Icons.house), findsOneWidget);
      expect(find.byIcon(Icons.phone), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.web), findsOneWidget);
      expect(find.byIcon(Icons.description), findsOneWidget);
      expect(find.byIcon(Icons.image), findsNWidgets(4));
      expect(find.byIcon(Icons.add_a_photo), findsNWidgets(4));
      expect(find.byIcon(Icons.location_on), findsNWidgets(2));
      expect(find.byIcon(Icons.location_searching_outlined), findsOneWidget);
    });

    testWidgets('check if validations working properly', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AddRestaurantPage()));

      await tester.pumpAndSettle();

      final restaurantName = find.byKey(const Key('name'));
      final restaurantPhone = find.byKey(const Key('number'));
      final restaurantEmail = find.byKey(const Key('email'));
      final restaurantWebsite = find.byKey(const Key('website'));
      final restaurantDescription = find.byKey(const Key('description'));
      final restaurantLatitude = find.byKey(const Key('latitude'));
      final restaurantLongitude = find.byKey(const Key('longitude'));
      final restaurantAddress = find.byKey(const Key('address'));
      final addRestaurant =
          find.widgetWithText(ElevatedButton, 'Add Restaurant');

      await tester.enterText(restaurantName, 'HE');
      await tester.enterText(restaurantPhone, '123');
      await tester.enterText(restaurantEmail, 'invalidemail');
      await tester.enterText(restaurantWebsite, 'invalidwebsite');
      await tester.enterText(restaurantDescription, '123456789');
      await tester.ensureVisible(addRestaurant);
      await tester.tap(addRestaurant);
      await tester.pumpAndSettle();
      expect(find.text('Invalid Restaurant Name'), findsOneWidget);
      expect(find.text('Invalid Phone Number'), findsOneWidget);
      expect(find.text('Invalid Email'), findsOneWidget);
      expect(find.text('Invalid URL'), findsOneWidget);
      expect(find.text('Description must be at least 10 characters'), findsOneWidget);
    });
  });
}
