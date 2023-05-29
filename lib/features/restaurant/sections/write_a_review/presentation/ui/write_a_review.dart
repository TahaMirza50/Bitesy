import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_review_app/features/restaurant/presentation/ui/restaurant.dart';
import 'package:resturant_review_app/features/restaurant/sections/write_a_review/presentation/bloc/write_a_review_bloc.dart';
import 'package:resturant_review_app/features/restaurant/sections/write_a_review/presentation/widgets/star_select.dart';
import 'package:resturant_review_app/screens/search_page/model/restaurant_model.dart';

import '../../../../widgets/star.dart';

class WriteAReview extends StatefulWidget {
  final RestaurantModel restaurantModel;
  const WriteAReview({super.key, required this.restaurantModel});

  @override
  State<WriteAReview> createState() => _WriteAReviewState();
}

class _WriteAReviewState extends State<WriteAReview> {
  int starsSelected = 0;
  List<File> _selectedImages = [];

  void setStarsSelected(int i) {
    setState(() {
      starsSelected = i;
    });
  }

  void selectImage() async {
    if (_selectedImages.length < 3) {
      final picker = ImagePicker();
      final pickedImage =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

      if (pickedImage != null) {
        setState(() {
          _selectedImages.add(File(pickedImage.path));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You can only upload 3 images"),
        ),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  final WriteAReviewBloc writeAReviewBloc = WriteAReviewBloc();

  @override
  Widget build(BuildContext context) {
    TextEditingController textarea = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: BlocConsumer<WriteAReviewBloc, WriteAReviewState>(
        bloc: writeAReviewBloc,
        listenWhen: (previous, current) => current is WriteAReviewActionState,
        buildWhen: (previous, current) => current is! WriteAReviewActionState,
        listener: (context, state) {
          if (state is NavigateToRestaurantHomeState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RestaurantPage(restaurantModel: widget.restaurantModel),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WriteAReviewLoadingState:
              return const Center(child: CircularProgressIndicator());
            case WriteAReviewErrorState:
              return const Center(child: Text("Error"));
            default:
              return _buildBody(context, textarea, formKey);
          }
        },
      ),
    );
  }

  SingleChildScrollView _buildBody(BuildContext context,
      TextEditingController textarea, GlobalKey<FormState> formKey) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Card(
            elevation: 0,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StarSelect(
                        starsSelected: starsSelected,
                        setStarsSelected: setStarsSelected),
                    const SizedBox(height: 6),
                    _buildReviewGuidelines(),
                    const SizedBox(height: 16),
                    _buildReviewTextArea(textarea, formKey),
                    const SizedBox(height: 16),
                    _buildCameraButton(),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        onPressed: () {
                          writeAReviewBloc.add(PostReviewEvent(
                            numReviews: widget.restaurantModel.numReviews,
                            avgRating: widget.restaurantModel.avgRating,
                            restaurantId: widget.restaurantModel.id,
                            avatar:
                                "https://www.woolha.com/media/2020/03/eevee.png",
                            rating: starsSelected,
                            review: textarea.text,
                            images: _selectedImages,
                            userId: FirebaseAuth.instance.currentUser!.uid
                                .toString(),
                            userEmail: FirebaseAuth.instance.currentUser!.email
                                .toString(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          minimumSize: const Size(200, 50),
                          shadowColor: Colors.grey,
                          elevation: 5,
                          backgroundColor: Colors.brown,
                          side: const BorderSide(
                              color: Colors.transparent,
                              width: 2,
                              style: BorderStyle.solid),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Post Review"),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  Padding _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.restaurantModel.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Form _buildReviewTextArea(
      TextEditingController textarea, GlobalKey<FormState> formKey) {
    return Form(
      key: formKey,
      child: TextFormField(
          maxLines: 20,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: textarea,
          cursorColor: Colors.brown,
          decoration: InputDecoration(
            hintText: "Enter Remarks",
            contentPadding: const EdgeInsets.all(15),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(color: Colors.grey, width: 2)),
          ),
          onChanged: (value) {},
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          }),
    );
  }

  Column _buildReviewGuidelines() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("A few things you need to consider",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600])),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Food",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Service",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Ambiance",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildCameraButton() {
    if (_selectedImages.isNotEmpty) {
      return Row(
        children: [
          Center(
            child: DottedBorder(
              strokeWidth: 1,
              dashPattern: [8, 4],
              strokeCap: StrokeCap.round,
              radius: const Radius.circular(20),
              color: Colors.grey,
              child: Container(
                child: IconButton(
                  onPressed: selectImage,
                  icon: const Icon(Icons.camera_alt_outlined),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                _selectedImages.length,
                (index) => Stack(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.all(8),
                      child: Image.file(
                        _selectedImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[500],
                            ),
                            padding: EdgeInsets.all(2),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: DottedBorder(
          strokeWidth: 1,
          dashPattern: [8, 4],
          strokeCap: StrokeCap.round,
          radius: const Radius.circular(20),
          color: Colors.grey,
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            child: IconButton(
              onPressed: selectImage,
              icon: const Icon(Icons.camera_alt_outlined),
            ),
          ),
        ),
      );
    }
  }
}
