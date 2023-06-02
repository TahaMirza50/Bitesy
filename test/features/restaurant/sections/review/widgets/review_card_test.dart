import 'package:Bitesy/constants/constants.dart';
import 'package:Bitesy/features/restaurant/sections/review/presentation/bloc/review_bloc.dart';
import 'package:Bitesy/features/restaurant/sections/review/widgets/review_card.dart';
import 'package:Bitesy/features/restaurant/widgets/star.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Bitesy/features/restaurant/data/models/restaurant_review_model.dart';
import 'package:Bitesy/features/restaurant/sections/review/domain/repositories/restaurant_review_repo.dart';

class MockReviewBloc extends Mock implements ReviewBloc {}

class MockRestaurantReviewRepository extends Mock
    implements RestaurantReviewRepository {}

class MockUser extends Mock implements User {}

void main() {
  late ReviewBloc reviewBloc;
  late RestaurantReviewModel review;
  late ReviewCard reviewCard;
  late MockRestaurantReviewRepository mockRepository;
  late MockUser mockUser;

  setUp(() {
    reviewBloc = MockReviewBloc();
    review = RestaurantReviewModel(
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
    );
    mockRepository = MockRestaurantReviewRepository();
    mockUser = MockUser();

    reviewCard = ReviewCard(
      review: review,
      reviewBloc: reviewBloc,
    );
  });

  testWidgets('ReviewCard renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: reviewCard,
        ),
      ),
    );

    // Verify that the review content is rendered
    expect(find.text(review.userName), findsOneWidget);
    expect(find.text(review.userEmail.split("@")[0]), findsOneWidget);
    expect(find.text(review.review), findsOneWidget);

    // Verify that the rating stars are rendered
    expect(find.byType(Star), findsNWidgets(review.rating));

    // Verify that the review images are rendered
    // expect(find.byType(Image), findsNWidgets(review.images.length));

    // Verify that the share button is rendered
    expect(find.text("Share"), findsOneWidget);
    expect(find.byIcon(Icons.share_outlined), findsOneWidget);

    // Verify that the report button is rendered
    expect(find.text("Report"), findsOneWidget);
    expect(find.byIcon(Icons.report_problem_outlined), findsOneWidget);
  });

  testWidgets('ReviewCard triggers shareContent', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: reviewCard,
        ),
      ),
    );

    // Tap the share button
    await tester.tap(find.text("Share"));
    await tester.pumpAndSettle();

    // Verify that shareContent is called
    // verify(reviewCard.shareContent()).called(1);
  });

  testWidgets('ReviewCard triggers reportReview', (WidgetTester tester) async {
    // Mock the reportReview function
    // when(mockRepository.reportReview(any, any)).thenAnswer((_) async {
    //   return Response(status: 200);
    // });

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: reviewCard,
        ),
      ),
    );

    // Tap the report button
    await tester.tap(find.text("Report"));
    await tester.pumpAndSettle();

    // Verify that reportReview is called
    // verify(reviewCard.reportReview()).called(1);

    // Verify that the SnackBar is shown for successful report
    expect(find.text('Review reported successfully'), findsOneWidget);
  });
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
