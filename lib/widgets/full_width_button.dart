import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';

enum FullWidthButtonType { primary, secondary }

class FullWidthButton extends StatelessWidget {
  final FullWidthButtonType type;
  final String text;
  final void Function() onPressed;
  final bool isDisabled;

  FullWidthButton(
      {Key? key,
      required this.type,
      required this.text,
      required this.onPressed,
      this.isDisabled = false})
      : super(key: key);

  Color getBgColor() {
    return type == FullWidthButtonType.primary
        ? ColorPlanet.primary
        : ColorPlanet.secondary;
  }

  Color getFontColor() {
    return type == FullWidthButtonType.primary
        ? Colors.white
        : ColorPlanet.primary;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.isDisabled ? null : this.onPressed,
      child: Text(
        this.text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: this.isDisabled ? Colors.grey.shade400 : getFontColor(),
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
        shape: StadiumBorder(),
        backgroundColor: this.isDisabled ? Colors.grey.shade50 : getBgColor(),
        elevation: 0,
      ),
    );
  }
}
