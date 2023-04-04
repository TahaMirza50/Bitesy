import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.brown),
            onPressed: () {},
          ),
          centerTitle: true,
          title: const Text(
            'Sign Up',
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
                "Create Account",
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Sign Up to get started.",
                style: TextStyle(
                    color: Color.fromARGB(255, 122, 102, 95),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Form(
                    child: Column(
                  children: [
                    TextField(
                      cursorColor: Colors.brown,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(16),
                          child: Icon(
                            Icons.person,
                            color: Colors.brown,
                          ),
                        ),
                        hintText: "Your Username",
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
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
                    TextField(
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
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
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
                      cursorColor: Colors.brown,
                      textInputAction: TextInputAction.done,
                      obscureText: _isObscure1,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            color: Colors.brown,
                            icon: Icon(_isObscure1
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure1 = !_isObscure1;
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
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 2)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      cursorColor: Colors.brown,
                      textInputAction: TextInputAction.done,
                      obscureText: _isObscure2,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            color: Colors.brown,
                            icon: Icon(_isObscure2
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure2 = !_isObscure2;
                              });
                            }),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Icon(
                            Icons.lock,
                            color: Colors.brown,
                          ),
                        ),
                        hintText: "Confirm Your Password",
                        contentPadding: const EdgeInsets.all(15),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 40,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                          ),
                          child: const Text(
                            'Sign Up',
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
                    text: "Already Have an Account?",
                    recognizer: TapGestureRecognizer()..onTap = () {},
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
