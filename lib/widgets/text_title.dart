import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class TextTitle extends StatelessWidget {
  final String title;
  final TextAlign? textAlign;

  const TextTitle({
    Key? key,
    required this.title,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      textAlign: this.textAlign ?? TextAlign.start,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
