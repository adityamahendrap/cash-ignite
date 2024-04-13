import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';
import 'package:progmob_magical_destroyers/widgets/full_width_button_bottom_bar.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(title: 'Edit Profile', centerTitle: true),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Form(
                    child: Column(
                      children: [
                        _textInput(
                          title: 'Name',
                          hintText: 'Name',
                          prefixIcon: Icons.person_outline,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          FullWidthButtonBottomBar(
            context: context,
            text: 'Save',
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _textInput({
    TextEditingController? controller,
    String? Function(String?)? validator,
    required String title,
    required String hintText,
    required IconData prefixIcon,
  }) {
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
          // controller: _emailController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // validator: (value) => _checkEmail(value),
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
