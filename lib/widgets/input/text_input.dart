import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';

class TextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String title;
  final String hintText;
  final IconData prefixIcon;

  TextInput({
    super.key,
    this.controller,
    this.validator,
    required this.title,
    required this.hintText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: this.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => this.validator!(value),
          textAlignVertical: TextAlignVertical.center,
          obscureText: false,
          cursorColor: ColorPlanet.primary,
          cursorErrorColor: ColorPlanet.primary,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.black,
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Color(0xff9E9E9E)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            filled: true,
            fillColor: Color.fromARGB(101, 241, 241, 241),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
      ],
    );
  }
}
