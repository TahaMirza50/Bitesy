import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_review_app/router/app_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                // TextField(
                //   style: const TextStyle(color: Colors.black),
                //   decoration: InputDecoration(
                //     suffixIcon: Padding(
                //         padding: const EdgeInsets.only(left: 20, right: 10),
                //         child: ElevatedButton(
                //           onPressed: (() {}),
                //           style: ElevatedButton.styleFrom(
                //             backgroundColor: Colors.brown,
                //             shape: const CircleBorder(),
                //           ),
                //           child: const Icon(
                //             Icons.search,
                //           ),
                //         )),
                //     filled: true,
                //     fillColor: Colors.white,
                //     hintText: 'Restaurant',
                //     border: const OutlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(16.0)),
                //     ),
                //     focusedBorder: const OutlineInputBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(16.0)),
                //         borderSide: BorderSide(color: Colors.brown, width: 2)),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 75,
                        width: 175,
                        child: ElevatedButton(
                            onPressed: () {
                              return context.go('/login');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: const BorderSide(
                                width: 2,
                                color: Colors.brown,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w100),
                            )),
                      ),
                      SizedBox(
                        height: 75,
                        width: 175,
                        child: ElevatedButton(
                            onPressed: () {
                              return context.go('/sign_up');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w100),
                            )),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            side: const BorderSide(
                              width: 2,
                              color: Colors.brown,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          icon: Image.network(
                              'http://pngimg.com/uploads/google/google_PNG19635.png'),
                          label: const Text(
                            "Continue with Google",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
