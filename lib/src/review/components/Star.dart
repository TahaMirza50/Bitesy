import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  const Star({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.red[600],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Icon(Icons.star_rounded, color: Colors.white, size: 30)),
      ),
    );
  }
}
