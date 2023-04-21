import 'package:flutter/material.dart';
import 'package:resturant_review_app/src/review/components/Star.dart';

class WriteAReview extends StatelessWidget {
  const WriteAReview({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textarea = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cuisines of Nepal',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Read our review guidelines',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: Colors.blue[400]),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          for (var i = 0; i < 5; i++) const Star(),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: Text("Select a Rating",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: textarea,
                        keyboardType: TextInputType.multiline,
                        maxLines: 20,
                        cursorColor: Colors.grey[800]!,
                        decoration: InputDecoration(
                            hintText: "Enter Remarks",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, color: Colors.grey[800]!),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, color: Colors.grey[800]!))),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                          onPressed: () {
                            print("Hello");

                            // Navigator.pushNamed(context, '/home');
                          },
                          child: const Text("Post Review"),
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
                                color: Colors.transparent,
                                width: 2,
                                style: BorderStyle.solid),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
