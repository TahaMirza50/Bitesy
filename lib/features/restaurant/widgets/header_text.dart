import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String header;
  final TextStyle textStyle;
  const HeaderText({super.key, required this.header, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(header, style: textStyle),
    );
  }
}


