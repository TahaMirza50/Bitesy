import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:Bitesy/features/login_and_signup/presentation/ui/login.dart';
import 'package:Bitesy/features/search_page/presentation/ui/search_page.dart';
import 'package:Bitesy/features/login_and_signup/presentation/ui/signup.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/twitter_login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<User?> signInWithTwitter({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final twitterLogin = TwitterLogin(
        apiKey: 'KPU7i1tFlIvuHMrW3gui5eaFn',
        apiSecretKey: 'WDGXfnZ0SNBNp04SBWmSwEMVHWN0zqWc0ZQSmSWlp3fw8tKdUt',
        redirectURI: 'twitter-login://');
    User? user;

    try {
      final result = await twitterLogin.loginV2();
      if (result.status == TwitterLoginStatus.loggedIn) {
        final credential = TwitterAuthProvider.credential(
            accessToken: result.authToken!, secret: result.authTokenSecret!);
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: AlertDialog(
              title: const Text(
                "Error",
                style:
                    TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
              ),
              content: Text(e.message!),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        },
      );
    }
    return user;
  }

  Future<User?> signInWithFacebook({required BuildContext context}) async {
    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final result = await FacebookAuth.instance
          .login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        //final userData = await FacebookAuth.instance.getUserData();
      }
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: AlertDialog(
              title: const Text(
                "Error",
                style:
                    TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
              ),
              content: Text(e.message!),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        },
      );
    }
    return user;
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignIn googleSignIn = GoogleSignIn();

    User? user;
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: AlertDialog(
              title: const Text(
                "Error",
                style:
                    TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
              ),
              content: Text(e.message!),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        },
      );
    }
    return user;
  }

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
                // SizedBox(
                //   height: MediaQuery.of(context).size.width*0.75,
                //   ),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()),
                              );
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            User? user =
                                await signInWithGoogle(context: context);
                            if (user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchPage()),
                              );
                            }
                          },
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
                          icon: Image.asset(
                            "assets/images/login_images/google.png",
                            fit: BoxFit.fill,
                          ),
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
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            User? user =
                                await signInWithFacebook(context: context);
                            if (user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchPage()),
                              );
                            }
                          },
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
                          icon: Image.asset(
                            "assets/images/login_images/facebook.png",
                            fit: BoxFit.fill,
                          ),
                          label: const Text(
                            "Continue with Facebook",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            User? user =
                                await signInWithTwitter(context: context);
                            if (user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchPage()),
                              );
                            }
                          },
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
                          icon: Image.asset(
                            "assets/images/login_images/twitter.png",
                            fit: BoxFit.fill,
                          ),
                          label: const Text(
                            "Continue with Twitter",
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
