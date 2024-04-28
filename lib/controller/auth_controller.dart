import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/login_type.dart';
import 'package:progmob_magical_destroyers/screens/get_started_screen.dart';
import 'package:progmob_magical_destroyers/screens/main/main_screen.dart';
import 'package:progmob_magical_destroyers/screens/sign_in_screen.dart';
import 'package:progmob_magical_destroyers/service/auth_service.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';

class AuthController {
  final AuthService _authService = AuthService();
  final GetStorage _box = GetStorage();
  final MoblieApiRequester _mobileApi = MoblieApiRequester();

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    // TODO: check if email not registered using oauth

    try {
      EasyLoading.show();
      await _mobileApi.register(
        name: name,
        email: email,
        password: password,
      );
    } on DioException catch (e) {
      if (e.response?.data['message']['email'] != null)
        AppSnackBar.error('Failed', e.response?.data['message']['email'][0]);
      else
        HelplessUtil.handleApiError(e);
      return;
    } finally {
      EasyLoading.dismiss();
    }

    Get.off(() => SignIn());
    AppSnackBar.success('Success',
        'Account created! Now you can sign in to enjoy our services. 🥳');
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    // TODO: check if email not registered using oauth

    try {
      EasyLoading.show();
      LoginData? data = await _mobileApi.login(
        email: email,
        password: password,
      );
      _box.write('token', data!.token);
      clog.info('Sign in success!');
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
      return;
    } finally {
      EasyLoading.dismiss();
    }

    Get.offAll(() => Main());
  }

  Future<void> signInWithGoogle() async {
    try {
      EasyLoading.show();
      final LoginData? result = await _authService.simulateGoogleOauth();
      if (result != null) {
        _box.write('token', result.token);
        Get.offAll(() => Main());
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
      AppSnackBar.error('Error', 'Sign in with Google failed');
    } finally {
      EasyLoading.dismiss();
    }
  }

  signInWithFacebook() {
    AppSnackBar.error('Error', 'Unimplemented feature');
  }

  signInWithGithub() {
    AppSnackBar.error('Error', 'Unimplemented feature');
  }

  void signOut() {
    _box.remove('token');
    clog.info('Signin out success. Token removed.');
    Get.offAll(() => GetStarted());
  }
}
