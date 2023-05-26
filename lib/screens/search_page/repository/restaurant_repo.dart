import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resturant_review_app/constants/constants.dart';
import 'package:resturant_review_app/screens/search_page/model/restaurant_model.dart';
import 'dart:convert';

final FirebaseFirestore _firestore = Constants.firestore;
final CollectionReference _restaurants = _firestore.collection('restaurant');

class Response {
  int status;
  String message;
  List<RestaurantModel> restaurantsList;
  Response({this.status = 0, this.message = "", required this.restaurantsList});
  int get getStatus => status;
  String get getMessage => message;
}

class RestaurantRepository {

  // Future<List<RestaurantModel>> getList() => Future.value(restaurantsList);

  static Future<Response> fetchRestaurantList() async {

    List<RestaurantModel> restaurantsList = [];

    Response response = Response(restaurantsList: restaurantsList);
    try {
      QuerySnapshot snapshot = await _restaurants.get();

      if (snapshot.size > 0) {
        for (QueryDocumentSnapshot document in snapshot.docs) {
          Map<String, dynamic>? documentData =
              document.data() as Map<String, dynamic>?;
          response.restaurantsList.add(RestaurantModel.fromJson(documentData!));
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

  static Future<Response> fetchRestaurantByName(String name) async{

        List<RestaurantModel> restaurantsList = [];

    Response response = Response(restaurantsList: restaurantsList);

        try {
      QuerySnapshot snapshot = await _restaurants.get();

      if (snapshot.size > 0) {
        for (QueryDocumentSnapshot document in snapshot.docs) {
          Map<String, dynamic>? documentData =
              document.data() as Map<String, dynamic>?;
          String documentName = (documentData!['name'] as String).toLowerCase();
          if (documentName.contains(name.toLowerCase())) {
          response.restaurantsList.add(RestaurantModel.fromJson(documentData));
        }
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
