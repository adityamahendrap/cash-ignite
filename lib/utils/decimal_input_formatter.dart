import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'^\d+,\d*$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    
    final newText = newValue.text;
    
    if (_regExp.hasMatch(newText)) {
      return newValue;
    }
    
    return oldValue;
  }
}