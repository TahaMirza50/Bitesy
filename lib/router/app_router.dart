import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_review_app/screens/login.dart';
import 'package:resturant_review_app/screens/signup.dart';
import 'package:resturant_review_app/screens/start.dart';


final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: "/",
      name: "start",
      builder: (context, state) => const HomePage(),
    ),

    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      path: "/sign_up",
      builder: (context, state) => const SignUpPage(),
    ),
  ],
);