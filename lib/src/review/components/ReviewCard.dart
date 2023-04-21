import 'package:flutter/material.dart';

import 'Star.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.woolha.com/media/2020/03/eevee.png'),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Alfred L.',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.photo, color: Colors.grey),
                          Text('1',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.photo, color: Colors.grey),
                          Text('1',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.photo, color: Colors.grey),
                          Text('1',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (var i = 0; i < 4; i++) const Star(),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("14 days ago",
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[850])),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Lorem ipsum idor Lorem ipsum idor Lorem ipsum idor Lorem ipsum idor Lorem ipsum idor Lorem ipsum idor",
                    style: TextStyle(fontSize: 16, color: Colors.grey[850])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
