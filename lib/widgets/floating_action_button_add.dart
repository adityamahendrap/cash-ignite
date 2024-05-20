import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';

class FloatingActionButtonAdd extends StatelessWidget {
  final Function() onPressed;
  const FloatingActionButtonAdd({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: this.onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      backgroundColor: ColorPlanet.primary,
      child: Icon(Icons.add),
    );
  }
}
