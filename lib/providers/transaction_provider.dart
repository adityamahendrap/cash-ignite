import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/list_tabungan_anggota_type.dart';
import 'package:progmob_magical_destroyers/types/transaction_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';

class TransactionProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isNominalValid = false;
  List<Tabungan> _transactionList = [];

  bool get isLoading => _isLoading;
  bool get isNominalValid => _isNominalValid;
  List<Tabungan> get transactionList => _transactionList;

  final MoblieApiRequester _apiRequester = MoblieApiRequester();

  set isNominalValid(bool value) {
    _isNominalValid = value;
    clog.debug('isNominalValid: $_isNominalValid');
    notifyListeners();
  }

  void getListTabunganAnggota(Anggota anggota) async {
    _isLoading = true;
    try {
      ListTabunganAnggota data = await _apiRequester
          .getListAllTabunganByAnggota(anggotaId: anggota.id);
      _transactionList = data.tabungan!;
      notifyListeners();
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearTransactionList() {
    _transactionList = [];
    notifyListeners();
  }
}
