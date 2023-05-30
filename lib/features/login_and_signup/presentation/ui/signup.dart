import 'package:Bitesy/constants/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:Bitesy/features/admin_page/widgets/image_helper.dart';
import 'package:Bitesy/features/login_and_signup/data/model/user.dart';
import 'package:Bitesy/features/login_and_signup/domain/repository/user_repository.dart';
import 'package:Bitesy/features/login_and_signup/presentation/ui/login.dart';
import 'package:Bitesy/features/search_page/presentation/ui/search_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  var currentSelectedGender = "M";
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController1 = TextEditingController();
  final TextEditingController _passController2 = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final subFormKey = GlobalKey<FormState>();
  final UploadImage uploadImage = UploadImage();

  static Future<User?> signInUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
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
                    key: formKey,
                    child: Column(
                      children: [
                        ImageField(uploadImage),
                        const SizedBox(
                          height: 20,
                        ),
                        dataField(context),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Enter min. 6 character'
                                  : null,
                          controller: _passController1,
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value != null &&
                                  value.compareTo(_passController1.text) != 0
                              ? 'Password does not match'
                              : null,
                          controller: _passController2,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 40,
                      child: ElevatedButton(
                          onPressed: () async {
                            final isValid = formKey.currentState!.validate();
                            final subIsValid =
                                subFormKey.currentState!.validate();
                            if (!isValid || !subIsValid) return;
                            setState(() {
                              isLoading = true;
                            });
                            User? user = await signInUsingEmailPassword(
                                email: _emailController.text,
                                password: _passController1.text,
                                context: context);
                            if (user != null) {
                              final String image;
                              if (uploadImage.getImage() != null) {
                                image = await uploadImage
                                    .upLoadToFirebase(FirebaseAuth.instance.currentUser!.uid);
                              } else {
                                image =
                                    'https://firebasestorage.googleapis.com/v0/b/bitesy-fa8bc.appspot.com/o/default%20avatar%2F804946.png?alt=media&token=b355751e-c501-4740-b263-2204d5e971d5';
                              }
                              final userModel = UserModel(
                                  id: FirebaseAuth.instance.currentUser!.uid,
                                  firstName: _firstNameController.text.trim(),
                                  lastName: _lastNameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  gender: currentSelectedGender,
                                  role: 'user',
                                  avatar: image);
                              ResponseUser response =
                                  await UserRepository.addUser(userModel);
                                  setState(() {
                                isLoading = false;
                                  });
                              if (response.getStatus == 400) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0)),
                                      child: AlertDialog(
                                        title: const Text(
                                          "Error",
                                          style: TextStyle(
                                              color: Colors.brown,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(response.getMessage),
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
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SearchPage()),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                          ),
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : const Text(
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
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
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

  Widget dataField(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: Form(
                key: subFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.isEmpty
                          ? 'Enter first name.'
                          : null,
                      controller: _firstNameController,
                      cursorColor: Colors.brown,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(16),
                          child: Icon(
                            Icons.person,
                            color: Colors.brown,
                          ),
                        ),
                        hintText: "First Name",
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
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.isEmpty
                          ? 'Enter last name.'
                          : null,
                      controller: _lastNameController,
                      cursorColor: Colors.brown,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(16),
                          child: Icon(
                            Icons.person,
                            color: Colors.brown,
                          ),
                        ),
                        hintText: "Last Name",
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
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Container(
              height: 55,
              child: FormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Icon(
                          currentSelectedGender == 'F'
                              ? Icons.female_rounded
                              : Icons.male_rounded,
                          color: Colors.brown,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(15),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide:
                              BorderSide(color: Colors.brown, width: 2)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: currentSelectedGender,
                        onChanged: (String? newValue) {
                          setState(() {
                            currentSelectedGender = newValue!;
                          });
                        },
                        items: ["M", "F"].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold)),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            )),
          ],
        ),
      ],
    );
  }

  Widget ImageField(UploadImage uploadImage) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
        child: Row(
          children: [
            const Icon(
              Icons.image,
              color: Colors.brown,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: uploadImage.getImage() != null
                    ? Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        height: 100,
                        child: Image.file(
                            fit: BoxFit.cover,
                            uploadImage.getImage()!.absolute),
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        height: 100,
                        child: Image.network(
                            fit: BoxFit.cover,
                            'https://firebasestorage.googleapis.com/v0/b/bitesy-fa8bc.appspot.com/o/default%20avatar%2F804946.png?alt=media&token=b355751e-c501-4740-b263-2204d5e971d5'),
                      )),
            IconButton(
              onPressed: () async {
                if (uploadImage.getImage() != null) {
                  await uploadImage.removeImage();
                  setState(() {});
                } else {
                  await uploadImage.getGalleryImage();
                  setState(() {});
                }
              },
              icon: uploadImage.getImage() != null
                  ? const Icon(Icons.delete)
                  : const Icon(Icons.add_a_photo),
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
