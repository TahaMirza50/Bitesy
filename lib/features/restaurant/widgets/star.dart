import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double starSize;

  const Star(
      {super.key,
      required this.width,
      required this.height,
      required this.color,
      required this.starSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child:
                Icon(Icons.star_rounded, color: Colors.white, size: starSize)),
      ),
    );
  }
}
