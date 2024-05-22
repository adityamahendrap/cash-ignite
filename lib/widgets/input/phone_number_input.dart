import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberInput extends StatelessWidget {
  final PhoneNumber initialValue;
  final TextEditingController controller;

  const PhoneNumberInput({super.key, required this.initialValue, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            // print(number.phoneNumber);
          },
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.DROPDOWN,
            useBottomSheetSafeArea: false,
            setSelectorButtonAsPrefixIcon: true,
            trailingSpace: false,
            useEmoji: true,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          initialValue: initialValue,
          textFieldController: controller,
          formatInput: true,
          inputDecoration: InputDecoration(
            prefix: SizedBox(width: 10),
            hintText: 'Phone Number',
            hintStyle: TextStyle(color: Color(0xff9E9E9E)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            filled: true,
            contentPadding: EdgeInsets.zero,
            fillColor: Color.fromARGB(101, 241, 241, 241),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          onSaved: (PhoneNumber number) {
            print('On Saved: $number');
          },
        ),
      ],
    );
  }
}
