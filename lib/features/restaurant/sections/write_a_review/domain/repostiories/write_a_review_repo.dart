import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resturant_review_app/constants/constants.dart';
import 'dart:convert';

import 'package:resturant_review_app/features/restaurant/data/models/restaurant_review_model.dart';

final FirebaseFirestore _firestore = Constants.firestore;
final CollectionReference _reviews = _firestore.collection('restaurant_review');

class Response {
  int status;
  String message;
  Response({this.status = 0, this.message = ""});
  int get getStatus => status;
  String get getMessage => message;
}

class WriteARestaurantReviewRepository {
  static Future<Response> createRestaurantReview(
      RestaurantReviewModel review) async {
    print("Inside create restaurant review repo");

    Response response = Response();
    try {
      await _reviews.doc(review.id).set(review.toJson());
      response.status = 200;
      response.message = "Restaurant Review created successfully";
    } catch (error) {
      response.status = 400;
      response.message = error.toString();
    }

    return response;
  }

  // update restaurant details
  static Future<Response> updateRestaurantDetails(int rating,
      String restaurantId, int totalRatings, String avgRating) async {
    print("Inside update restaurant details repo");

    CollectionReference restaurant = _firestore.collection('restaurant');

    Response response = Response();
    try {
      await restaurant.doc(restaurantId).update({
        'avgRating': (((double.parse(avgRating) * totalRatings) + rating) /
                (totalRatings + 1))
            .toString(),
        'numReviews': FieldValue.increment(1),
        'ratingCounts.$rating': FieldValue.increment(1)
      });
      response.status = 200;
      response.message = "Restaurant Details updated successfully";
    } catch (error) {
      response.status = 400;
      response.message = error.toString();
    }

    return response;
  }
}
