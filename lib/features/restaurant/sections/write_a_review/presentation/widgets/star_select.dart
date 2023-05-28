// assign each star with an id initially with a transparent background

import 'package:flutter/material.dart';
import 'package:resturant_review_app/features/restaurant/widgets/star.dart';

class StarSelect extends StatelessWidget {
  final int starsSelected;
  final ValueSetter<int> setStarsSelected;

  StarSelect({required this.setStarsSelected, required this.starsSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 1; i <= 5; i++)
          InkWell(
            onTap: () {
              setStarsSelected(i);
            },
            key: Key(i.toString()),
            child: i <= starsSelected
                ? Star(
                    color: Colors.brown,
                    starSize: 25,
                    height: 30,
                    width: 30,
                  )
                : Star(
                    color: Colors.grey,
                    starSize: 25,
                    height: 30,
                    width: 30,
                  ),
          )
      ],
    );
  }
}
