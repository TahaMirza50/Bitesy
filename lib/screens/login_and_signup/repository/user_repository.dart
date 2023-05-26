import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturant_review_app/constants/constants.dart';
import 'package:resturant_review_app/screens/login_and_signup/model/user.dart';


final FirebaseFirestore _firestore = Constants.firestore;
final CollectionReference _users = _firestore.collection('users');

class Response{
  int status;
  String message;
  Response({this.status = 0, this.message = ""});
  int get getStatus => status;
  String get getMessage => message;
}

class UserRepository{
  
  static Future<Response> addUser(UserModel user) async {
    Response response = Response();

    DocumentReference documentReference = _users.doc(user.id);

    await documentReference.set(user.toJson()).whenComplete(() {
      response.status = 200;
      response.message = "User added successfully";
    }).catchError((e){
      response.status = 400;
      response.message = "Something went wrong";
    }); 

    return response;
    // await FirebaseFirestore.instance.collection("users").add(user.toJson()).whenComplete(
    //   () => Get.snackbar("Success", "Your account has been created.",
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.brown,
    //       colorText: Colors.white) 
    // ).catchError((error,stackTrace){
    //   Get.snackbar("OOPS!", "Something went wrong.", 
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.brown,
    //       colorText: Colors.white);
    // });
  }

}
