import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Function()? onSeeAll;
  final bool showButton;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
    this.showButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          showButton ? _seeAllButton() : Container(),
        ],
      ),
    );
  }

  TextButton _seeAllButton() {
    return TextButton(
      onPressed: onSeeAll,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.zero,
        ),
      ),
      child: Text(
        'See all',
        style: TextStyle(
          color: ColorPlanet.primary,
          fontSize: 18,
        ),
      ),
    );
  }
}
