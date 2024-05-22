import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/widgets/input/text_input.dart'
    as input;

class DateInput extends StatelessWidget {
  final TextEditingController controller;
  final Function onTap;
  const DateInput({
    super.key,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: input.TextInput(
            title: 'Birthday',
            hintText: 'Birthday',
            prefixIcon: Icons.cake_outlined,
            controller: controller,
            readOnly: true,
            onTap: onTap,
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => onTap(),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorPlanet.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
