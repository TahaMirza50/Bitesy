import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
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
                    child: Column(
                  children: [
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
                          onPressed: () {},
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
