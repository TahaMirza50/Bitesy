import 'package:flutter/material.dart';
import 'package:resturant_review_app/src/review/components/ReviewCard.dart';

import 'WriteAReview.dart';

class Review extends StatelessWidget {
  const Review({super.key});

  @override
  Widget build(BuildContext context) {
    return WriteAReview();
    // return ListView.builder(
    //     itemCount: 5,
    //     itemBuilder: ((context, index) {
    //       return ReviewCard() as Widget;
    //     }));
  }
}
