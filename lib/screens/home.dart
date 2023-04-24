import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resturant_review_app/router/app_router.dart';
import 'package:resturant_review_app/screens/login.dart';
import 'package:resturant_review_app/screens/signup.dart';
import 'package:resturant_review_app/screens/start.dart';

class LoggedHomePage extends StatefulWidget {
  const LoggedHomePage({super.key});

  @override
  State<LoggedHomePage> createState() => _LoggedHomePageState();
}

class _LoggedHomePageState extends State<LoggedHomePage> {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/homepage3.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                        height: 30,
                        width: 100,
                        child: ElevatedButton(
                            onPressed: () async {
                              FacebookAuth.instance.logOut();
                              GoogleSignIn().disconnect();
                              FirebaseAuth.instance.signOut().then((value) => {
                              Navigator.popUntil(
                                context,
                                ModalRoute.withName('/'),
                              )
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text(
                              "Log Out",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w100),
                            )),
                      ),
                SizedBox(
                  height: (MediaQuery.of(context).size.width*0.75)-30,
                  ),
                const Text(
                  "Bitesy",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                const Text("Explore Restaurants all around you",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.w100)),
                const SizedBox(
                  height: 100,
                ),
                TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: ElevatedButton(
                          onPressed: (() {}),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(
                            Icons.search,
                          ),
                        )),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Restaurant',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        borderSide: BorderSide(color: Colors.brown, width: 2)),
                  ),
                ),],
            ),
          ),
        ),
      ),
    ));
  }
}