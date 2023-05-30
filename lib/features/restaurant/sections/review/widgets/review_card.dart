import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_review_app/features/restaurant/data/models/restaurant_review_model.dart';
import 'package:resturant_review_app/features/restaurant/sections/review/domain/repositories/restaurant_review_repo.dart';
import 'package:share_plus/share_plus.dart';

import '../../../widgets/star.dart';
import '../presentation/bloc/review_bloc.dart';
import 'outlined_button.dart';

class ReviewCard extends StatefulWidget {
  final RestaurantReviewModel review;
  final ReviewBloc reviewBloc;

  const ReviewCard({super.key, required this.review, required this.reviewBloc});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool isLoading = false;
  bool isReported = false;
  int reportStatus = 0;

  @override
  void initState() {
    super.initState();
    checkReviewReportStatus();
  }

  Future<void> shareContent() async {
    try {
      await Share.share("Check out this review: ${widget.review.review}");
      print('Share completed successfully.');
    } catch (e) {
      print('Error sharing: $e');
    }
  }

  Future<void> checkReviewReportStatus() async {
    try {
      bool resp = await RestaurantReviewRepository.isReviewReported(
          widget.review.id, FirebaseAuth.instance.currentUser!.uid);

      setState(() {
        isReported = resp;
      });
    } catch (e) {
      print('Error checking report status: $e');
    }
  }

  Future<void> reportReview() async {
    setState(() {
      isLoading = true;
    });

    try {
      Response resp = await RestaurantReviewRepository.reportReview(
          widget.review.id, FirebaseAuth.instance.currentUser!.uid);

      setState(() {
        reportStatus = resp.status;
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error reporting: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          _buildUserProfile(widget.review.userName, widget.review.avatar),
          const SizedBox(height: 4),
          _buildRatingStars(widget.review.rating),
          _buildReviewContent(widget.review.review),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
                widget.review.images.length,
                (index) => Row(
                      children: [
                        _buildReviewImage(context, widget.review.images[index]),
                        const SizedBox(width: 8),
                      ],
                    )),
          ),
          // Row(
          //   children: [
          //     // create a small sized image that enlarges when clickedd
          //     _buildReviewImage(context),
          //     const SizedBox(width: 8),
          //     _buildReviewImage(context),
          //     const SizedBox(width: 8),
          //     _buildReviewImage(context),
          //   ],
          // ),
          _buildButtonRow(),
        ],
      ),
    );
  }

  GestureDetector _buildReviewImage(BuildContext context, String image) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.0)),
                                child: Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                  height: 400.0,
                                ),
                              ),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Image.network(image, height: 50, width: 50),
    );
  }

  Align _buildReviewContent(String reviewContent) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(reviewContent,
            style: TextStyle(fontSize: 16, color: Colors.grey[850])),
      ),
    );
  }

  Row _buildUserProfile(String userName, String avatar) {
    print(userName);
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(avatar),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
              child: Text(userName != "" ? userName : "Anonymous",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            // create a row of icons and text with eahc icon text grouped
            // together
            // Row(
            //   children: [
            //     const Icon(Icons.camera_alt_outlined, color: Colors.grey),
            //     const SizedBox(width: 4),
            //     const Text("245",
            //         style:
            //             TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            //     const SizedBox(width: 8),
            //     const Icon(Icons.camera_alt_outlined, color: Colors.grey),
            //     const SizedBox(width: 4),
            //     const Text("245",
            //         style:
            //             TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            //     const SizedBox(width: 8),
            //     const Icon(Icons.camera_alt_outlined, color: Colors.grey),
            //     const SizedBox(width: 4),
            //     const Text("245",
            //         style:
            //             TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            //   ],
            // ),
          ],
        ),
      ],
    );
  }

  Row _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 170,
          child: ReviewOutlinedButton(
              label: "Share",
              icon: Icons.share_outlined,
              onPressed: shareContent),
        ),
        isReported
            ? SizedBox(
                width: 170,
                child: ReviewOutlinedButton(
                  label: "Reported",
                  icon: Icons.report_problem_outlined,
                  disabled: true,
                ),
              )
            : SizedBox(
                width: 170,
                child: ReviewOutlinedButton(
                  label: "Report",
                  icon: Icons.report_problem_outlined,
                  onPressed: () async {
                    await reportReview();
                    if (reportStatus == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Review reported successfully'),
                        ),
                      );
                    } else if (reportStatus == 500) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Review already reported'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error reporting review'),
                        ),
                      );
                    }
                  },
                ),
              )
      ],
    );
  }

  Row _buildRatingStars(int rating) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < rating; i++)
          const Star(width: 25, height: 25, starSize: 15, color: Colors.brown),
      ],
    );
  }
}
