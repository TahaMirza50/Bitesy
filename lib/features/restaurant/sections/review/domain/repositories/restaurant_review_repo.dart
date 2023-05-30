import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resturant_review_app/constants/constants.dart';
import 'dart:convert';

import 'package:resturant_review_app/features/restaurant/data/models/restaurant_review_model.dart';

final FirebaseFirestore _firestore = Constants.firestore;
final CollectionReference _reviews = _firestore.collection('restaurant_review');

class Response {
  int status;
  String message;
  List<RestaurantReviewModel> reviewList;
  Response({this.status = 0, this.message = "", required this.reviewList});
  int get getStatus => status;
  String get getMessage => message;
}

class RestaurantReviewRepository {
  static Future<Response> fetchRestaurantReviews(String restaurantId) async {
    List<RestaurantReviewModel> reviewList = [];
    print("Inside restaurant repo");

    Response response = Response(reviewList: reviewList);
    try {
      QuerySnapshot snapshot = await _reviews
          .where("restaurantId", isEqualTo: restaurantId)
          .orderBy("timestamp", descending: true)
          .get();

      if (snapshot.size > 0) {
        for (QueryDocumentSnapshot document in snapshot.docs) {
          Map<String, dynamic>? documentData =
              document.data() as Map<String, dynamic>?;
          response.reviewList
              .add(RestaurantReviewModel.fromJson(documentData!));
        }
      }
      response.status = 200;
      response.message = "Restaurant Review read successfully";
    } catch (error) {
      response.status = 400;
      response.message = error.toString();
    }

    return response;
  }

  static Future<bool> isReviewReported(String reviewId, String userId) async {
    bool isReported = false;
    try {
      DocumentSnapshot snapshot = await _reviews.doc(reviewId).get();
      if (snapshot.exists) {
        Map<String, dynamic>? documentData =
            snapshot.data() as Map<String, dynamic>?;

        RestaurantReviewModel review =
            RestaurantReviewModel.fromJson(documentData!);

        if (review.reportList.contains(userId)) {
          isReported = true;
        }
      }
    } catch (error) {
      print(error);
    }

    return isReported;
  }

  static Future<Response> reportReview(String reviewId, String userId) async {
    Response response = Response(reviewList: []);
    try {
      DocumentSnapshot snapshot = await _reviews.doc(reviewId).get();
      if (snapshot.exists) {
        Map<String, dynamic>? documentData =
            snapshot.data() as Map<String, dynamic>?;
        RestaurantReviewModel review =
            RestaurantReviewModel.fromJson(documentData!);

        if (review.reportList.contains(userId)) {
          response.status = 500;
          response.message = "Review already reported";
          return response;
        }

        review.reportList.add(userId);
        await _reviews.doc(reviewId).update({
          "reportCount": FieldValue.increment(1),
          "reportList": review.reportList
        });
        response.status = 200;
        response.message = "Review reported successfully";
      } else {
        response.status = 400;
        response.message = "Review not found";
      }
    } catch (error) {
      response.status = 400;
      response.message = error.toString();
    }

    return response;
  }
}
