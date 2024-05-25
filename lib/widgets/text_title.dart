import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final String title;
  final TextAlign? textAlign;
  final Color color;

  const TextTitle({
    Key? key,
    required this.title,
    this.textAlign,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      textAlign: this.textAlign ?? TextAlign.start,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: this.color,
      ),
    );
  }
}
