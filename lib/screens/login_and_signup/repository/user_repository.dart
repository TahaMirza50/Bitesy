import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturant_review_app/constants/constants.dart';
import 'package:resturant_review_app/screens/login_and_signup/model/user.dart';


final FirebaseFirestore _firestore = Constants.firestore;
final CollectionReference _users = _firestore.collection('users');

class ResponseUser{
  int status;
  String message;
  UserModel user;
  ResponseUser({this.status = 0, this.message = "",required this.user});
  int get getStatus => status;
  String get getMessage => message;
}

class UserRepository{
  
  static Future<ResponseUser> addUser(UserModel user) async {
    
    ResponseUser response = ResponseUser(user: user);

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

  static Future<ResponseUser> fetchUserByEmail(String email) async{

    ResponseUser response = ResponseUser(user: UserModel(
      id: "",
      firstName: "",
      email: "",
      lastName: "",
      gender: "",
      role: "",
    ));
    try{

      QuerySnapshot snapshot = await _users.get();

      if(snapshot.size > 0){

        for(QueryDocumentSnapshot document in snapshot.docs){

          Map<String, dynamic>? documentData = document.data() as Map<String, dynamic>?;

          String documentEmail = (documentData!['email'] as String).toLowerCase();
          
          if(documentEmail == email.toLowerCase()){
            UserModel user = UserModel.fromJson(documentData);
            response.user = user;
            response.status = 200;
            response.message = "User read successfully";

          }
        }
      }
    } catch(error) {  
      response.status = 400;
      response.message = error.toString();
    }
    return response;
  }

}
