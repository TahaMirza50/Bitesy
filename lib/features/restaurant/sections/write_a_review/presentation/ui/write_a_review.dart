import 'package:flutter/material.dart';

import '../../../../widgets/star.dart';

class WriteAReview extends StatelessWidget {
  const WriteAReview({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textarea = TextEditingController();

    return Scaffold(
      body: _buildBody(context, textarea),
    );
  }

  SingleChildScrollView _buildBody(
      BuildContext context, TextEditingController textarea) {
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
                    _buildRatingStars(),
                    const SizedBox(height: 6),
                    _buildReviewGuidelines(),
                    const SizedBox(height: 16),
                    _buildReviewTextArea(textarea),
                    const SizedBox(height: 16),
                    _buildPostReviewButton(context),
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
              const Text(
                'Cuisines of Nepal',
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

  TextField _buildReviewTextArea(TextEditingController textarea) {
    return TextField(
      controller: textarea,
      keyboardType: TextInputType.multiline,
      maxLines: 20,
      cursorColor: Colors.grey[800]!,
      decoration: InputDecoration(
          hintText: "Enter Remarks",
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.grey[800]!),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.grey[800]!))),
    );
  }

  SizedBox _buildPostReviewButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        onPressed: () {
          // Navigator.pushNamed(context, '/home');
        },
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          minimumSize: const Size(200, 50),
          shadowColor: Colors.grey,
          elevation: 5,
          backgroundColor: Colors.red[600],
          side: const BorderSide(
              color: Colors.transparent, width: 2, style: BorderStyle.solid),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text("Post Review"),
      ),
    );
  }

  Row _buildRatingStars() {
    return Row(
      children: [
        for (var i = 0; i < 5; i++)
          const Star(width: 25, height: 25, starSize: 15, color: Colors.brown),
      ],
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
}
