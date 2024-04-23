import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/add_anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/delete_anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/edit_anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/get_anggota_list.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/get_anggota_list_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/get_current_user_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/login_rype.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/register_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';

class MoblieApiRequester {
  static const String BASE_URL = 'https://mobileapis.manpits.xyz/api';

  final Dio dio = Dio();

  MoblieApiRequester() {
    _configureDio();
  }

  void _configureDio() {
    dio.options.baseUrl = BASE_URL;
    dio.options.connectTimeout = Duration(seconds: 5);
    dio.options.receiveTimeout = Duration(seconds: 3);
    dio.options.headers = {'Authorization': 'Bearer token'};
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

  Future<LoginData?> login({
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
    LoginData data = _getDataFromResponse(response, LoginData.fromJson);

    return data;
  }

  Future<RegisterData?> register({
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
    RegisterData data = _getDataFromResponse(response, RegisterData.fromJson);

    return data;
  }

  Future<void> logout() async {
    String url = '/logout';
    await dio.get(url);
  }

  Future<GetCurrentUserData?> getCurrentUser() async {
    String url = '/user';
    Response response = await dio.get(url);

    GetCurrentUserData data =
        _getDataFromResponse(response, GetCurrentUserData.fromJson);
    return data;
  }

  Future<GetAnggotaListData?> getAnggotaList() async {
    String url = '/anngota';
    Response response = await dio.get(
      url,
    );
    GetAnggotaListData data =
        _getDataFromResponse(response, GetAnggotaListData.fromJson);

    return data;
  }

  Future<GetAnggotaData?> getAnggota({
    required int id,
  }) async {
    String url = '/anngota/$id';
    Response response = await dio.get(
      url,
    );
    GetAnggotaData data =
        _getDataFromResponse(response, GetAnggotaData.fromJson);

    return data;
  }

  Future<AddAnggotaData?> addAnggota({
    required String nomorInduk,
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
    AddAnggotaData data =
        _getDataFromResponse(response, AddAnggotaData.fromJson);

    return data;
  }

  Future<UpdateAnggotaData?> updateAnggota({
    required int id,
    required String nomorInduk,
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
    UpdateAnggotaData data =
        _getDataFromResponse(response, UpdateAnggotaData.fromJson);

    return data;
  }

  Future<DeleteAnggotaData?> deleteAnggota({
    required int id,
  }) async {
    String url = '/anngota/$id';
    Response response = await dio.delete(
      url,
    );
    DeleteAnggotaData data =
        _getDataFromResponse(response, DeleteAnggotaData.fromJson);

    return data;
  }
}
