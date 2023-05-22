import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resturant_review_app/screens/search_page/model/restaurant_model.dart';
import '../../../constants/firebase.dart';
import 'dart:convert';

final FirebaseFirestore _firestore = ConnectFirebase.firestore;
final CollectionReference _restaurants = _firestore.collection('restaurant');

class Response {
  int status;
  String message;
  Response({this.status = 0, this.message = ""});
  int get getStatus => status;
  String get getMessage => message;
}

class RestaurantRepository {
  static List<RestaurantModel> restaurantsList = [];

  // Future<List<RestaurantModel>> getList() => Future.value(restaurantsList);

  static Future<Response> fetchRestaurantList() async {

    restaurantsList = [];
    Response response = Response();
    try {
      QuerySnapshot snapshot = await _restaurants.get();

      if (snapshot.size > 0) {
        for (QueryDocumentSnapshot document in snapshot.docs) {
          Map<String, dynamic>? documentData =
              document.data() as Map<String, dynamic>?;
          restaurantsList.add(RestaurantModel.fromJson(documentData!));
        }
      }
      response.status = 200;
      response.message = "Restaurant read successfully";
    } catch (error) {
      response.status = 400;
      response.message = error.toString();
    }

    // await _restaurants.get().then((event) {
    //   restaurantsList = event.docs
    //       .map((doc) => RestaurantModel.fromJson(doc.data()))
    //       .toList();

    // }).onError((error, stackTrace) {
    //   response.status = 400;
    //   response.message = "Something went wrong";
    // });

    return response;
  }

  static Future<Response> fetchRestaurantByName(String name) async{
    
    restaurantsList = [];

    Response response = Response();

        try {
      QuerySnapshot snapshot = await _restaurants.get();

      if (snapshot.size > 0) {
        for (QueryDocumentSnapshot document in snapshot.docs) {
          Map<String, dynamic>? documentData =
              document.data() as Map<String, dynamic>?;
          String documentName = (documentData!['name'] as String).toLowerCase();
          if (documentName.contains(name.toLowerCase())) {
          restaurantsList.add(RestaurantModel.fromJson(documentData));
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
