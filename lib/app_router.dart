import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_review_app/login.dart';
import 'package:resturant_review_app/signup.dart';
import 'package:resturant_review_app/start.dart';


final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: "/",
      name: "home",
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