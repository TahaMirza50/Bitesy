import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Bitesy/constants/constants.dart';
import 'package:Bitesy/features/search_page/data/model/restaurant_model.dart';
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

  static Future<Response> fetchRestaurantByNameAndRating(
      String name, String rating) async {
    List<RestaurantModel> restaurantsList = [];

    Response response = Response(restaurantsList: restaurantsList);

    try {
      QuerySnapshot snapshot = await _restaurants.get();

      if (snapshot.size > 0) {
        for (QueryDocumentSnapshot document in snapshot.docs) {
          Map<String, dynamic>? documentData =
              document.data() as Map<String, dynamic>?;
          String documentName = (documentData!['name'] as String).toLowerCase();
          
          String documentRating = documentData['avgRating'] as String;
          int restRating = double.parse(documentRating).round();


          if (documentName.contains(name.toLowerCase()) && rating == 'None') {
            response.restaurantsList
                .add(RestaurantModel.fromJson(documentData));
          } else if (documentName.contains(name.toLowerCase()) &&
              restRating == double.parse(rating)) {
            response.restaurantsList
                .add(RestaurantModel.fromJson(documentData));
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

  static Future<Response> addRestaurant(RestaurantModel restaurantModel) async {
    Response response = Response(restaurantsList: [restaurantModel]);

    DocumentReference documentReference = _restaurants.doc(restaurantModel.id);

    await documentReference.set(restaurantModel.toJson()).whenComplete(() {
      response.status = 200;
      response.message = "User added successfully";
    }).catchError((e) {
      response.status = 400;
      response.message = "Something went wrong";
    });
    return response;
  }
}
