import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';

class TextLabel extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  TextLabel({
    super.key,
    required this.text,
    this.bgColor = ColorPlanet.secondary,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: this.bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(this.text, style: TextStyle(color: this.textColor)),
    );
  }
}
