import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Bitesy/constants/constants.dart';
import 'package:Bitesy/features/search_page/data/model/restaurant_model.dart';
import 'dart:convert';

final FirebaseFirestore _firestore = Constants.firestore;
final CollectionReference _restaurants = _firestore.collection('restaurant');

class Response {
  int status;
  String message;
  RestaurantModel? restaurantModel;
  Response({this.status = 0, this.message = "", this.restaurantModel});

  int get getStatus => status;
  String get getMessage => message;
}

class RestaurantRepository {
  static Future<Response> fetchRestaurant(String id) async {
    Response response = Response();

    try {
      QuerySnapshot snapshot =
          await _restaurants.where("id", isEqualTo: id).get();

      if (snapshot.size > 0) {
        for (QueryDocumentSnapshot document in snapshot.docs) {
          Map<String, dynamic>? documentData =
              document.data() as Map<String, dynamic>?;
          response.restaurantModel = RestaurantModel.fromJson(documentData!);
        }
      }
      response.status = 200;
      response.message = "Restaurant read successfully";
    } catch (error) {
      response.status = 400;
      response.message = error.toString();
    }

    return response;
  }
}
