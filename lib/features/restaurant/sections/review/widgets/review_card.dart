import 'package:flutter/material.dart';

import '../../../widgets/star.dart';

class ReviewCard extends StatelessWidget {
  // final String profileUrl;
  // final String name;
  // final String review;

  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          _buildUserProfile(),
          const SizedBox(height: 4),
          _buildRatingStars(),
          _buildReviewContent(),
          _buildButtonRow(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Padding _buildReviewContent() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
          "Lorem ipsum idor Lorem ipsum idor Lorem ipsum idor Lorem ipsum idor Lorem ipsum idor Lorem ipsum idor",
          style: TextStyle(fontSize: 16, color: Colors.grey[850])),
    );
  }

  Row _buildUserProfile() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage:
              NetworkImage('https://www.woolha.com/media/2020/03/eevee.png'),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
              child: const Text('Alfred L.',
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
          onPressed: () {},
          icon: const Icon(Icons.sentiment_very_dissatisfied_outlined),
          label: const Text('Dislike'),
        ),
      ],
    );
  }

  Row _buildRatingStars() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < 4; i++)
          const Star(width: 25, height: 25, starSize: 15, color: Colors.brown),
      ],
    );
  }
}
