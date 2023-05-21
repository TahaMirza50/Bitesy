import 'package:flutter/material.dart';

class ReviewOutlinedButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const ReviewOutlinedButton(
      {super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
    );
  }
}
