import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/anggota_detail_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/anggota_list_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/current_user_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/inserted_transaksi_tabungan_type.dart'
    as ittt;
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/list_tabungan_anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/login_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/master_jenis_transaksi_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/register_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/saldo_anggota_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';

class MoblieApiRequester {
  static const String BASE_URL = 'https://mobileapis.manpits.xyz/api';

  final Dio dio = Dio();
  late String? token;
  final GetStorage _box = GetStorage();

  MoblieApiRequester() {
    _loadToken();
    _setDioOptions();
  }

  void _loadToken() {
    token = _box.read('token');
  }

  void _setDioOptions() {
    dio.options.baseUrl = BASE_URL;
    dio.options.connectTimeout = Duration(seconds: 10);
    dio.options.receiveTimeout = Duration(seconds: 3);
    dio.options.headers = {'Authorization': 'Bearer $token'};
  }

  T _getDataFromResponse<T>(
    Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    Map<String, dynamic> jsonData = response.data['data'];

    clog.info('Response Data:');
    HelplessUtil.printPrettyJson(jsonData);

    return fromJson(jsonData);
  }

  Future<Login?> login({
    required String email,
    required String password,
  }) async {
    String url = '/login';
    Response response = await dio.post(
      url,
      data: {
        'email': email,
        'password': password,
      },
    );
    return _getDataFromResponse(response, Login.fromJson);
  }

  Future<Register?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    String url = '/register';
    Response response = await dio.post(
      url,
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    return _getDataFromResponse(response, Register.fromJson);
  }

  Future<void> logout() async {
    String url = '/logout';
    await dio.get(url);
  }

  Future<CurrentUser?> getCurrentUser() async {
    String url = '/user';
    Response response = await dio.get(url);
    return _getDataFromResponse(response, CurrentUser.fromJson);
  }

  Future<AnggotaList?> getAnggotaList() async {
    String url = '/anggota';
    Response response = await dio.get(
      url,
    );
    return _getDataFromResponse(response, AnggotaList.fromJson);
  }

  Future<AnggotaDetail?> getAnggotaDetail({
    required int id,
  }) async {
    String url = '/anngota/$id';
    Response response = await dio.get(
      url,
    );
    return _getDataFromResponse(response, AnggotaDetail.fromJson);
  }

  Future<AnggotaDetail?> addAnggota({
    required int nomorInduk,
    required String nama,
    required String alamat,
    required String tglLahir, // 2000-03-31
    required String telepon,
  }) async {
    String url = '/anggota';
    Response response = await dio.post(
      url,
      data: {
        'nomor_induk': nomorInduk,
        'nama': nama,
        'alamat': alamat,
        'tgl_lahir': tglLahir,
        'telepon': telepon,
      },
    );
    return _getDataFromResponse(response, AnggotaDetail.fromJson);
  }

  Future<AnggotaDetail?> updateAnggota({
    required int id,
    required int nomorInduk,
    required String nama,
    required String alamat,
    required String tglLahir,
    required String telepon,
    required bool status,
  }) async {
    String url = '/anggota/$id';
    Response response = await dio.put(
      url,
      data: {
        'nomor_induk': nomorInduk,
        'nama': nama,
        'alamat': alamat,
        'tgl_lahir': tglLahir,
        'telepon': telepon,
        'status': status,
      },
    );
    return _getDataFromResponse(response, AnggotaDetail.fromJson);
  }

  Future<AnggotaDetail?> deleteAnggota({
    required int id,
  }) async {
    String url = '/anggota/$id';
    Response response = await dio.delete(url);
    return _getDataFromResponse(response, AnggotaDetail.fromJson);
  }

  Future<MasterJenisTransaksi?> getMasterJenisTransaksi() async {
    String url = '/jenistransaksi';
    Response response = await dio.get(url);
    return _getDataFromResponse(response, MasterJenisTransaksi.fromJson);
  }

  Future<ListTabunganAnggota> getListAllTabunganByAnggota({
    required int anggotaId,
  }) async {
    String url = '/tabungan/$anggotaId';
    Response response = await dio.get(url);
    return _getDataFromResponse(response, ListTabunganAnggota.fromJson);
  }

  Future<ittt.InsertedTransaksiTabungan> insertTransaksiTabunganByAnggotaId({
    required String anggotaId,
    required int trxId,
    required int trxNominal,
  }) async {
    String url = '/tabungan';
    Response response = await dio.post(
      url,
      data: {
        'anggota_id': anggotaId,
        'trx_id': trxId,
        'trx_nominal': trxNominal,
      },
    );

    Map<String, dynamic> dataJson = response.data['data'];
    Map<String, dynamic> reqJson = response.data['req'];

    clog.info('Response Data:');
    HelplessUtil.printPrettyJson(dataJson);

    return ittt.InsertedTransaksiTabungan(
      data: ittt.Data.fromJson(dataJson),
      req: ittt.Req.fromJson(reqJson),
    );
  }

  Future<SaldoAnggota> getSaldoByAnggotaId({required String anggotaId}) async {
    String url = '/saldo/$anggotaId';
    Response response = await dio.get(url);
    return _getDataFromResponse(response, SaldoAnggota.fromJson);
  }
}
