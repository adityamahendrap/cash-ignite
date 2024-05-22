
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If the new value is empty, return it directly
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove any non-digit characters
    final newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Format the number with periods as thousands separators
    final number = int.parse(newText);
    final formattedText = HelplessUtil.formatNumber(number);

    // Calculate the new cursor position
    final newCursorPosition = formattedText.length;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }
}
