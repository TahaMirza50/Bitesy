import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:resturant_review_app/constants/constants.dart';
import 'package:resturant_review_app/screens/admin_page/ui/utilities.dart';
import 'package:resturant_review_app/screens/search_page/model/restaurant_model.dart';
import 'package:resturant_review_app/screens/search_page/repository/restaurant_repo.dart';

class AddRestaurantPage extends StatefulWidget {
  const AddRestaurantPage({super.key});

  @override
  State<AddRestaurantPage> createState() => _AddRestaurantPageState();
}

class _AddRestaurantPageState extends State<AddRestaurantPage> {
  final UploadImage uploadImageOne = UploadImage();
  final UploadImage uploadImageTwo = UploadImage();
  final UploadImage uploadImageThree = UploadImage();
  final UploadImage uploadImageMenu = UploadImage();

  final TextEditingController _imageOneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
            'Add Restaurant',
            style: TextStyle(
                color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 25),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter Restaurant Information",
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
                        FormField(
                            "Restaurant Name",
                            Icons.house,
                            _nameController,
                            TextInputType.emailAddress,
                            (value) => value != null && value.length < 3
                                ? "Invalid Restaurant Name"
                                : null,
                            1),
                        const SizedBox(
                          height: 20,
                        ),
                        FormField("Restaurant Number", Icons.phone,
                            _phoneController, TextInputType.number, (value) {
                          if (value != null &&
                              RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)")
                                  .hasMatch(value)) {
                            return null;
                          } else {
                            return "Invalid Phone Number";
                          }
                        }, 1),
                        const SizedBox(
                          height: 20,
                        ),
                        FormField(
                            "Restaurant Email",
                            Icons.email,
                            _emailController,
                            TextInputType.emailAddress,
                            (value) =>
                                value != null && !EmailValidator.validate(value)
                                    ? 'Invalid email'
                                    : null,
                            1),
                        const SizedBox(
                          height: 20,
                        ),
                        FormField(
                            "http://www.example.com",
                            Icons.web,
                            _websiteController,
                            TextInputType.emailAddress,
                            (value) => value != null && !validator.url(value)
                                ? 'Invalid URL'
                                : null,
                            1),
                        const SizedBox(
                          height: 20,
                        ),
                        FormField(
                            "Restaurant Description",
                            Icons.description,
                            _descController,
                            TextInputType.emailAddress, (value) {
                          if (value != null && value.length < 10) {
                            return "Description must be at least 10 characters";
                          } else {
                            return null;
                          }
                        }, 5),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Enter Restaurant Images",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 122, 102, 95),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        // Container(
                        //   width: 200,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(16),
                        //       border: Border.all(color: Colors.grey)),
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //         left: 15, top: 15, bottom: 15),
                        //     child: Row(
                        //       children: [
                        //         const Icon(
                        //           Icons.image,
                        //           color: Colors.brown,
                        //         ),
                        //         const SizedBox(
                        //           width: 5,
                        //         ),
                        //         Expanded(
                        //             child: uploadImageOne.getImage() != null
                        //                 ? SizedBox(
                        //                     height: 100,
                        //                     child: Image.file(uploadImageOne
                        //                         .getImage()!
                        //                         .absolute),
                        //                   )
                        //                 : Container(
                        //                     height: 100,
                        //                     color: Colors.white,
                        //                   )),
                        //         IconButton(
                        //           onPressed: () async {
                        //             if (uploadImageOne.getImage() != null) {
                        //               await uploadImageOne.removeImage();
                        //               setState(() {});
                        //             } else {
                        //               await uploadImageOne.getGalleryImage();
                        //               setState(() {});
                        //             }
                        //           },
                        //           icon: uploadImageOne.getImage() != null
                        //               ? const Icon(Icons.delete)
                        //               : const Icon(Icons.add_a_photo),
                        //           color: Colors.grey,
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        ImageField(uploadImageOne),
                        const SizedBox(
                          height: 20,
                        ),
                        ImageField(uploadImageTwo),
                        const SizedBox(
                          height: 20,
                        ),
                        ImageField(uploadImageThree),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Enter Menu Images",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 122, 102, 95),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        ImageField(uploadImageMenu)
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
                            if (!isValid) return;
                            if (uploadImageOne.getImage() == null ||
                                uploadImageTwo.getImage() == null ||
                                uploadImageThree.getImage() == null ||
                                uploadImageMenu.getImage() == null) {
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
                                      content: const Text("Upload all images."),
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
                              return;
                            }
                            final String imageOne = await uploadImageOne
                                .upLoadToFirebase(_nameController.text);
                            final String imageTwo = await uploadImageTwo
                                .upLoadToFirebase(_nameController.text);
                            final String imageThree = await uploadImageThree
                                .upLoadToFirebase(_nameController.text);
                            final String imageMenu = await uploadImageMenu
                                .upLoadToFirebase(_nameController.text);
                            final RestaurantModel restaurant = RestaurantModel(
                                id: Constants.IDGenerator.v1(),
                                name: _nameController.text,
                                address: "Gulshan",
                                email: _emailController.text,
                                phoneNum: _phoneController.text,
                                website: _websiteController.text,
                                description: _descController.text,
                                numReviews: 0,
                                avgRating: "0.0",
                                images: [imageOne, imageTwo, imageThree],
                                menu: imageMenu
                                );
                                Response response = await RestaurantRepository.addRestaurant(restaurant);
                                if (response.getStatus == 200) {
                                  Navigator.of(context).pop();
                                }; 
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                          ),
                          child: const Text(
                            'Add Restaurant',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
                    ? SizedBox(
                        height: 100,
                        child: Image.file(uploadImage.getImage()!.absolute),
                      )
                    : Container(
                        height: 100,
                        color: Colors.white,
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

  Widget FormField(
      String hintText,
      IconData icon,
      TextEditingController controller,
      TextInputType keyboardType,
      String? Function(String?)? validator,
      int maxLines) {
    return TextFormField(
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controller,
      cursorColor: Colors.brown,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: controller.clear,
          icon: const Icon(Icons.clear),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(16),
          child: Icon(
            icon,
            color: Colors.brown,
          ),
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.all(15),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            borderSide: BorderSide(color: Colors.brown, width: 2)),
      ),
      onChanged: (value) {},
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
    );
  }
}
