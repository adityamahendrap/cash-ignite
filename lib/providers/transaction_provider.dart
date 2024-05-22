import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';

class TransactionProvider extends ChangeNotifier {
  bool _isNominalValid = false;

  bool get isNominalValid => _isNominalValid;

  set isNominalValid(bool value) {
    _isNominalValid = value;
    clog.debug('isNominalValid: $_isNominalValid');
    notifyListeners();
  }
}
