import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_review_app/features/restaurant/sections/review/presentation/ui/restaurant_review.dart';
import 'package:resturant_review_app/screens/search_page/ui/search_page.dart';
import 'package:resturant_review_app/screens/start.dart';

import 'features/restaurant/presentation/ui/restaurant.dart';
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
      debugShowCheckedModeBanner: false,
    title: 'Bitesy',
    theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ), 
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder:(context,snapshot){
        if(snapshot.hasData){
          return const SearchPage();
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
