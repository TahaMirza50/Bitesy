import 'package:flutter/material.dart';
import 'package:resturant_review_app/features/restaurant/sections/review/widgets/header_text.dart';
import 'package:resturant_review_app/features/restaurant/sections/review/widgets/outlined_button.dart';
import 'package:resturant_review_app/features/restaurant/sections/write_a_review/presentation/ui/write_a_review.dart';

import '../../../../widgets/star.dart';
import '../../widgets/review_card.dart';

class RestaurantReview extends StatefulWidget {
  const RestaurantReview({super.key});

  @override
  State<RestaurantReview> createState() => _RestaurantReviewState();
}

class _RestaurantReviewState extends State<RestaurantReview> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          _buildLeaveAReview(),
          _buildRecommendedReviews(),
        ],
      ),
    );
  }

  Widget _buildLeaveAReview() {
    return Container(
      color: Colors.white,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
          child: Column(
            children: [
              const HeaderText(
                  header: "Leave a Review",
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildPostReviewCard(context),
              const SizedBox(height: 8),
              _buildButtonRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedReviews() {
    return Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            child: Column(
              children: [
                const HeaderText(
                    header: "Recommended Reviews",
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildReviewsOverview(),
                  ],
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return ReviewCard();
                    })
              ],
            )));
  }

  Expanded _buildReviewsOverview() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              const HeaderText(
                  header: "Overall Rating",
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Row(
                children: _buildReviewStars,
              ),
              const SizedBox(height: 8),
              HeaderText(
                  header: "2,324 reviews",
                  textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600])),
            ],
          ),
          Column(
            children: [
              for (var i = 0; i < 5; i++) _buildProgressBar(i),
            ],
          ),
        ],
      ),
    );
  }

  Row _buildProgressBar(int i) {
    return Row(
      children: [
        Text('${5 - i}',
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black)),
        const SizedBox(width: 8),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
          width: 150,
          height: 12,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: LinearProgressIndicator(
              value: i / 10 as double,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
              backgroundColor: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> get _buildReviewStars {
    return [
      for (var i = 0; i < 5; i++)
        const Star(width: 25, height: 25, starSize: 15, color: Colors.brown),
    ];
  }

  Card _buildPostReviewCard(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WriteAReview()),
              );
            },
            child: Column(
              children: [
                Row(
                  children: [
                    for (var i = 0; i < 5; i++)
                      const Star(
                          width: 25,
                          height: 25,
                          starSize: 15,
                          color: Colors.amber),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Tap to review...",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600])),
                ),
              ],
            )),
      ),
    );
  }

  Row _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          width: 170,
          child: ReviewOutlinedButton(
              label: "Add Photo", icon: Icons.camera_alt_outlined),
        ),
        const SizedBox(
          width: 170,
          child: ReviewOutlinedButton(
              label: "Check In", icon: Icons.check_circle_outline),
        ),
      ],
    );
  }
}
