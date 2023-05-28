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
      QuerySnapshot snapshot = await _reviews.where("restaurantId", isEqualTo: restaurantId).get();

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
}
