import 'package:flutter/material.dart';

class ReviewOutlinedButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool disabled;
  Future<void> Function()? onPressed;

  ReviewOutlinedButton(
      {super.key,
      required this.label,
      required this.icon,
      this.onPressed,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: disabled ? null : onPressed ?? () {},
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
