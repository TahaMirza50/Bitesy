import 'package:Bitesy/constants/constants.dart';
import 'package:Bitesy/features/restaurant/sections/write_a_review/presentation/bloc/write_a_review_bloc.dart';
import 'package:Bitesy/features/restaurant/widgets/star.dart';
import 'package:Bitesy/features/search_page/data/model/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:Bitesy/features/restaurant/sections/write_a_review/presentation/widgets/star_select.dart';
import 'package:Bitesy/features/restaurant/sections/write_a_review/presentation/ui/write_a_review.dart';
import 'package:mockito/mockito.dart';

class MockWriteAReviewBloc extends Mock implements WriteAReviewBloc {}

void main() {
  late MockWriteAReviewBloc mockWriteAReviewBloc;

  setUp(() {
    mockWriteAReviewBloc = MockWriteAReviewBloc();
  });
  group('WriteAReview', () {
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
        menu: '');

    testWidgets('renders header correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: WriteAReview(restaurantModel: restaurantModel),
      ));

      expect(find.text(restaurantModel.name), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('star selection updates correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: WriteAReview(restaurantModel: restaurantModel),
      ));

      // Initially, all stars should have a grey background
      expect(find.byWidgetPredicate((widget) {
        if (widget is Star && widget.color == Colors.grey) {
          return true;
        }
        return false;
      }), findsNWidgets(5));

      // Tap on the third star
      await tester.tap(find.byKey(Key('3')));
      await tester.pump();

      // Verify that the first three stars have a different background color
      expect(find.byWidgetPredicate((widget) {
        if (widget is Star && widget.color != Colors.grey) {
          return true;
        }
        return false;
      }), findsNWidgets(3));
    });

    testWidgets('entering review text updates the value',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: WriteAReview(restaurantModel: restaurantModel),
      ));

      final reviewText = 'This is my review';
      await tester.enterText(find.byType(TextFormField), reviewText);
      await tester.pump();

      expect(find.text(reviewText), findsOneWidget);
    });
  });
}
