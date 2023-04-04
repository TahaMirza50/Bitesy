import 'package:flutter/material.dart';
import 'package:resturant_review_app/login.dart';
import 'package:resturant_review_app/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_review_app/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const HomePage(),
    );
  }
}
