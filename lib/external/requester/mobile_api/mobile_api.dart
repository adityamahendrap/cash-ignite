import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/add_anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/delete_anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/edit_anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/get_anggota_ltype.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/get_anggota_list_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/get_current_user_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/login_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/register_type.dart';
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
    Login data = _getDataFromResponse(response, Login.fromJson);

    return data;
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
    Register data = _getDataFromResponse(response, Register.fromJson);

    return data;
  }

  Future<void> logout() async {
    String url = '/logout';
    await dio.get(url);
  }

  Future<GetCurrentUser?> getCurrentUser() async {
    String url = '/user';
    Response response = await dio.get(url);

    GetCurrentUser data =
        _getDataFromResponse(response, GetCurrentUser.fromJson);
    return data;
  }

  Future<GetAnggotaList?> getAnggotaList() async {
    String url = '/anggota';
    Response response = await dio.get(
      url,
    );
    GetAnggotaList data =
        _getDataFromResponse(response, GetAnggotaList.fromJson);

    return data;
  }

  Future<GetAnggota?> getAnggota({
    required int id,
  }) async {
    String url = '/anngota/$id';
    Response response = await dio.get(
      url,
    );
    GetAnggota data =
        _getDataFromResponse(response, GetAnggota.fromJson);

    return data;
  }

  Future<AddAnggota?> addAnggota({
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
    AddAnggota data =
        _getDataFromResponse(response, AddAnggota.fromJson);

    return data;
  }

  Future<UpdateAnggota?> updateAnggota({
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
    UpdateAnggota data =
        _getDataFromResponse(response, UpdateAnggota.fromJson);

    return data;
  }

  Future<DeleteAnggota?> deleteAnggota({
    required int id,
  }) async {
    String url = '/anggota/$id';
    Response response = await dio.delete(url);
    DeleteAnggota data =
        _getDataFromResponse(response, DeleteAnggota.fromJson);

    return data;
  }
}
