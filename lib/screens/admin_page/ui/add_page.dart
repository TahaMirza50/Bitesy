import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:Bitesy/constants/constants.dart';
import 'package:Bitesy/screens/admin_page/ui/form_field.dart';
import 'package:Bitesy/screens/admin_page/ui/image_helper.dart';
import 'package:Bitesy/screens/admin_page/ui/location_picker.dart';
import 'package:Bitesy/screens/search_page/model/restaurant_model.dart';
import 'package:Bitesy/screens/search_page/repository/restaurant_repo.dart';

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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

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
                        FormFieldWidget(
                            hintText: "Restaurant Name",
                            icon: Icons.house,
                            controller: _nameController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                value != null && value.length < 3
                                    ? "Invalid Restaurant Name"
                                    : null,
                            maxLines: 1),
                        const SizedBox(
                          height: 20,
                        ),
                        FormFieldWidget(
                            hintText: "Restaurant Number",
                            icon: Icons.phone,
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value != null &&
                                  RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)")
                                      .hasMatch(value)) {
                                return null;
                              } else {
                                return "Invalid Phone Number";
                              }
                            },
                            maxLines: 1),
                        const SizedBox(
                          height: 20,
                        ),
                        FormFieldWidget(
                            hintText: "Restaurant Email",
                            icon: Icons.email,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                value != null && !EmailValidator.validate(value)
                                    ? 'Invalid email'
                                    : null,
                            maxLines: 1),
                        const SizedBox(
                          height: 20,
                        ),
                        FormFieldWidget(
                            hintText: "http://www.example.com",
                            icon: Icons.web,
                            controller: _websiteController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                value != null && !validator.url(value)
                                    ? 'Invalid URL'
                                    : null,
                            maxLines: 1),
                        const SizedBox(
                          height: 20,
                        ),
                        FormFieldWidget(
                            hintText: "Restaurant Description",
                            icon: Icons.description,
                            controller: _descController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value != null && value.length < 10) {
                                return "Description must be at least 10 characters";
                              } else {
                                return null;
                              }
                            },
                            maxLines: 5),
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
                        ImageField(uploadImageMenu),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Select Location",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 122, 102, 95),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        FormFieldWidget(
                            hintText: 'Latitude',
                            icon: Icons.location_on,
                            controller: _latitudeController,
                            keyboardType: TextInputType.number,
                            validator: (value) => value != null && value.isEmpty
                                ? "invalid value"
                                : null,
                            maxLines: 1),
                        const SizedBox(
                          height: 20,
                        ),
                        FormFieldWidget(
                            hintText: 'Longitude',
                            icon: Icons.location_on,
                            controller: _longitudeController,
                            keyboardType: TextInputType.number,
                            validator: (value) => value != null && value.isEmpty
                                ? "invalid value"
                                : null,
                            maxLines: 1),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          enabled: false,
                          controller: _addressController,
                          decoration: const InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(16),
                              child: Icon(
                                Icons.location_searching_outlined,
                                color: Colors.brown,
                              ),
                            ),
                            hintText: "Restaurant Address",
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (_latitudeController.text.trim().isEmpty ||
                                  _longitudeController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Please enter latitude and longitude")));
                                            return;
                              }
                              List<Placemark> placemarks =
                                  await placemarkFromCoordinates(
                                      double.parse(
                                          _latitudeController.text.trim()),
                                      double.parse(
                                          _longitudeController.text.trim()));
                              setState(() {
                                _addressController.text =
                                    "${placemarks[0].subLocality!}, ${placemarks[0].locality!}, ${placemarks[0].administrativeArea!}, ${placemarks[0].country}.";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                            ),
                            child: const Text(
                              'Check Address',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
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
                               ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Please upload all images.")));
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
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
                                address: _addressController.text,
                                email: _emailController.text,
                                phoneNum: _phoneController.text,
                                website: _websiteController.text,
                                description: _descController.text,
                                numReviews: 0,
                                latitude: _latitudeController.text.trim(),
                                longitude: _longitudeController.text.trim(),
                                avgRating: "0.0",
                                ratingCounts: {
                                  '5': 0,
                                  '4': 0,
                                  '3': 0,
                                  '2': 0,
                                  '1': 0
                                },
                                images: [imageOne, imageTwo, imageThree],
                                menu: imageMenu);
                            Response response =
                                await RestaurantRepository.addRestaurant(
                                    restaurant);
                            setState(() {
                              isLoading = false;
                            });
                            if (response.getStatus == 200) {
                              Navigator.of(context).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                          ),
                          child: !isLoading
                              ? const Text(
                                  'Add Restaurant',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : const CircularProgressIndicator(
                                  color: Colors.white,
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
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16)),
                        height: 100,
                        child: Image.file(uploadImage.getImage()!.absolute),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(16)),
                        height: 100,
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
