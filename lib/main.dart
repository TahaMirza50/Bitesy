import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resturant_review_app/src/review/Review.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_review_app/screens/home.dart';
import 'package:resturant_review_app/screens/start.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
    title: 'Bitesy',
    theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ), 
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder:(context,snapshot){
        if(snapshot.hasData){
          return const LoggedHomePage();
        } else {
          return const HomePage();
        }
      } ),
    );
  }
}

// MaterialApp.router(
//       title: 'Bitesy',
//       theme: ThemeData(
//         primarySwatch: Colors.brown,
//         fontFamily: GoogleFonts.poppins().fontFamily,
//       ), 
      
//       routerConfig:router
//     );
