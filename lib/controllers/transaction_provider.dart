import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/list_tabungan_anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/saldo_anggota_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';

class TransactionProvider extends ChangeNotifier {
  bool _isLoadingList = false;
  bool _isLoadingSaldo = false;

  bool _isNominalValid = false;
  int _saldo = 0;
  List<Tabungan> _transactionList = [];

  bool get isLoadingList => _isLoadingList;
  bool get isLoadingSaldo => _isLoadingSaldo;
  bool get isNominalValid => _isNominalValid;
  List<Tabungan> get transactionList => _transactionList;
  int get saldo => _saldo;

  set isNominalValid(bool value) {
    _isNominalValid = value;
    notifyListeners();
  }

  Future<void> getListTabunganAnggota(Anggota anggota) async {
    _isLoadingList = true;
    try {
      final MobileApiRequester _apiRequester = MobileApiRequester();
      ListTabunganAnggota data = await _apiRequester
          .getListAllTabunganByAnggota(anggotaId: anggota.id);
      _transactionList = data.tabungan!;
      notifyListeners();
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    } finally {
      _isLoadingList = false;
      notifyListeners();
    }
  }

  Future<void> getSaldo(Anggota anggota) async {
    _isLoadingSaldo = true;
    try {
      final MobileApiRequester _apiRequester = MobileApiRequester();
      SaldoAnggota data = await _apiRequester.getSaldoByAnggotaId(
          anggotaId: anggota.id.toString());
      _saldo = data.saldo!;
      notifyListeners();
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    } finally {
      _isLoadingSaldo = false;
      notifyListeners();
    }
  }

  void clearTransactionList() {
    _transactionList = [];
    notifyListeners();
  }

  void clearSaldo() {
    _saldo = 0;
    notifyListeners();
  }
}
