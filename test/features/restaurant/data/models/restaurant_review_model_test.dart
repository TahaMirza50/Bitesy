import 'package:Bitesy/features/restaurant/data/models/restaurant_review_model.dart';
import 'package:test/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('RestaurantReviewModel Tests', () {
    test('Create RestaurantReviewModel instance from JSON', () {
      Map<String, dynamic> json = {
        'id': '1',
        'restaurantId': '123',
        'userId': '456',
        'userName': 'John Doe',
        'userEmail': 'johndoe@example.com',
        'avatar': '',
        'review': 'Great restaurant!',
        'rating': 5,
        'timestamp': Timestamp.fromDate(DateTime(2022, 1, 1)),
        'reportCount': 2,
        'reportList': [],
        'images': [],
      };

      RestaurantReviewModel review = RestaurantReviewModel.fromJson(json);

      expect(review.id, '1');
      expect(review.restaurantId, '123');
      expect(review.userId, '456');
      expect(review.userName, 'John Doe');
      expect(review.userEmail, 'johndoe@example.com');
      expect(review.avatar, '');
      expect(review.review, 'Great restaurant!');
      expect(review.rating, 5);
      expect(review.timestamp, Timestamp.fromDate(DateTime(2022, 1, 1)));
      expect(review.reportCount, 2);
      expect(review.reportList, []);
      expect(review.images, []);
    });

    test('Create JSON from RestaurantReviewModel instance', () {
      RestaurantReviewModel review = RestaurantReviewModel(
        id: '1',
        restaurantId: '123',
        userId: '456',
        userName: 'John Doe',
        userEmail: 'johndoe@example.com',
        avatar: '',
        review: 'Great restaurant!',
        rating: 5,
        timestamp: Timestamp.fromDate(DateTime(2022, 1, 1)),
        reportCount: 2,
        reportList: [],
        images: [],
      );

      Map<String, dynamic> json = review.toJson();

      expect(json['id'], '1');
      expect(json['restaurantId'], '123');
      expect(json['userId'], '456');
      expect(json['userName'], 'John Doe');
      expect(json['userEmail'], 'johndoe@example.com');
      expect(json['avatar'], '');
      expect(json['review'], 'Great restaurant!');
      expect(json['rating'], 5);
      expect(json['timestamp'], Timestamp.fromDate(DateTime(2022, 1, 1)));
      expect(json['reportCount'], 2);
      expect(json['reportList'], []);
      expect(json['images'], []);
    });

   
  });
}
