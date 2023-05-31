import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Bitesy/features/restaurant/presentation/ui/restaurant.dart';
import 'package:Bitesy/features/search_page/presentation/ui/search_page.dart';
import 'package:Bitesy/features/login_and_signup/presentation/ui/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
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
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.brown),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: const Text(
            'Login',
            style: TextStyle(
                color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 25),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back!",
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Enter your credentials to continue",
                style: TextStyle(
                    color: Color.fromARGB(255, 122, 102, 95),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          key: const ValueKey("emailField"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Invalid email'
                                  : null,
                          controller: _emailController,
                          cursorColor: Colors.brown,
                          decoration: const InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(16),
                              child: Icon(
                                Icons.mail,
                                color: Colors.brown,
                              ),
                            ),
                            hintText: "Your Email",
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 2)),
                          ),
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          key: const ValueKey("passwordField"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Enter min. 6 characters'
                                  : null,
                          controller: _passController,
                          cursorColor: Colors.brown,
                          textInputAction: TextInputAction.done,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                color: Colors.brown,
                                icon: Icon(_isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(16),
                              child: Icon(
                                Icons.lock,
                                color: Colors.brown,
                              ),
                            ),
                            hintText: "Your Password",
                            contentPadding: const EdgeInsets.all(15),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 2)),
                          ),
                        ),
                      ],
                    )),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    text: "Forgot Password?",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: const TextStyle(
                        color: Colors.brown, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 40,
                      child: ElevatedButton(
                        key: const ValueKey("loginButton"),
                          onPressed: () async {
                            final isValid = formKey.currentState!.validate();
                            if (!isValid) return;
                            User? user = await loginUsingEmailPassword(
                                email: _emailController.text,
                                password: _passController.text,
                                context: context);
                                
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
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: "Don't Have Account?",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
                      },
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
