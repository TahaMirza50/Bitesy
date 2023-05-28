import 'package:flutter/material.dart';
import 'package:resturant_review_app/features/restaurant/data/models/restaurant_review_model.dart';
import 'package:share_plus/share_plus.dart';

import '../../../widgets/star.dart';

class ReviewCard extends StatelessWidget {
  final RestaurantReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          _buildUserProfile(review.userName, review.avatar),
          const SizedBox(height: 4),
          _buildRatingStars(review.rating),
          _buildReviewContent(review.review),
          const SizedBox(height: 8),
          Row(
            children: [
              // create a small sized image that enlarges when clickedd
              _buildReviewImage(context),
              const SizedBox(width: 8),
              _buildReviewImage(context),
              const SizedBox(width: 8),
              _buildReviewImage(context),
            ],
          ),
          _buildButtonRow(),
        ],
      ),
    );
  }

  GestureDetector _buildReviewImage(BuildContext context) {
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
                                child: Image.asset(
                                  "assets/images/menu_images/manu.webp",
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
      child: Image.asset("assets/images/menu_images/manu.webp",
          height: 50, width: 50),
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
              child: Text(userName != "null" ? userName : "Anonymous",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            // create a row of icons and text with eahc icon text grouped
            // together
            Row(
              children: [
                const Icon(Icons.camera_alt_outlined, color: Colors.grey),
                const SizedBox(width: 4),
                const Text("245",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                const Icon(Icons.camera_alt_outlined, color: Colors.grey),
                const SizedBox(width: 4),
                const Text("245",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                const Icon(Icons.camera_alt_outlined, color: Colors.grey),
                const SizedBox(width: 4),
                const Text("245",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Row _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.lightbulb_outline),
          label: const Text('Useful'),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.sentiment_very_satisfied_outlined),
          label: const Text('Funny'),
        ),
        OutlinedButton.icon(
          onPressed: () async {
            await Share.shareXFiles([XFile("assets/images/menu_images/manu.webp")],
                text: 'Hello Hardees Restaurant');
          },
          icon: const Icon(Icons.share_outlined),
          label: const Text('Share'),
        ),
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
