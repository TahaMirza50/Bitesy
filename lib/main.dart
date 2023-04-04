import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_review_app/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      routerConfig:router
    );
  }
}
