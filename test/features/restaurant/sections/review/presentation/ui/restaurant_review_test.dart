import 'package:Bitesy/constants/constants.dart';
import 'package:Bitesy/features/restaurant/data/models/restaurant_review_model.dart';
import 'package:Bitesy/features/restaurant/sections/review/presentation/bloc/review_bloc.dart';
import 'package:Bitesy/features/restaurant/sections/review/presentation/ui/restaurant_review.dart';
import 'package:Bitesy/features/restaurant/sections/review/widgets/review_card.dart';
import 'package:Bitesy/features/restaurant/sections/write_a_review/presentation/ui/write_a_review.dart';
import 'package:Bitesy/features/search_page/data/model/restaurant_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockReviewBloc extends Mock implements ReviewBloc {}

void main() {
  late MockReviewBloc reviewBloc;
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

  setUp(() {
    reviewBloc = MockReviewBloc();
  });

  group('RestaurantReview widget test', () {
    testWidgets('renders RestaurantReview loading state',
        (WidgetTester tester) async {
      // Set up mock states for the bloc
      when(reviewBloc.state).thenAnswer((_) => ReviewLoadingState());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ReviewBloc>.value(
            value: reviewBloc,
            child: RestaurantReview(restaurantModel: restaurantModel),
          ),
        ),
      );

      // Verify that the loading state is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ReviewCard), findsNothing);
      // Add more assertions based on the loading state
    });

    testWidgets('renders RestaurantReview success state',
        (WidgetTester tester) async {
      // Set up mock states for the bloc
      final reviews = [
        RestaurantReviewModel(
          id: Constants.IDGenerator.v1(),
          restaurantId: Constants.IDGenerator.v1(),
          userId: Constants.IDGenerator.v1(),
          rating: 5,
          images: [''],
          avatar: '',
          review: 'review',
          userEmail: 'userEmail',
          userName: 'userName',
          reportCount: 0,
          reportList: [],
          timestamp: Timestamp.now(),
        ),
                RestaurantReviewModel(
          id: Constants.IDGenerator.v1(),
          restaurantId: Constants.IDGenerator.v1(),
          userId: Constants.IDGenerator.v1(),
          rating: 5,
          images: [''],
          avatar: '',
          review: 'review',
          userEmail: 'userEmail',
          userName: 'userName',
          reportCount: 0,
          reportList: [],
          timestamp: Timestamp.now(),
        ),
      ];
      when(reviewBloc.state)
          .thenAnswer((_) => ReviewSuccessState(reviews: reviews));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ReviewBloc>.value(
            value: reviewBloc,
            child: RestaurantReview(restaurantModel: restaurantModel),
          ),
        ),
      );

      // Verify that the review cards are displayed
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ReviewCard), findsNWidgets(reviews.length));
      // Add more assertions based on the success state
    });

    testWidgets('navigates to WriteAReview screen',
        (WidgetTester tester) async {
      // Set up mock states for the bloc
      when(reviewBloc.state)
          .thenAnswer((_) => NavigateToWriteAReviewActionState());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ReviewBloc>.value(
            value: reviewBloc,
            child: RestaurantReview(restaurantModel: restaurantModel),
          ),
        ),
      );

      // Wait for the navigation to complete
      await tester.pumpAndSettle();

      // Verify that the WriteAReview screen is navigated to
      expect(find.byType(WriteAReview), findsOneWidget);
      // Add more assertions based on the navigation
    });
  });
}
