import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/user_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/login_type.dart';
import 'package:progmob_magical_destroyers/screens/get_started_screen.dart';
import 'package:progmob_magical_destroyers/screens/main/main_screen.dart';
import 'package:progmob_magical_destroyers/screens/sign_in_screen.dart';
import 'package:progmob_magical_destroyers/services/auth_service.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';

class AuthController {
  final AuthService _authService = AuthService();
  final GetStorage _box = GetStorage();
  final MoblieApiRequester _mobileApi = MoblieApiRequester();

  void _saveToken(String token) {
    _box.write('token', token);
  }

  void _saveUser(User user) {
    _box.write('user', user.toJson());
  }

  void _addAccountToRemember(String email, String password) {
    List<Map<String, dynamic>> rememberedAccounts =
        _box.read('rememberedAccounts') ?? [];

    bool alreadyRemembered =
        rememberedAccounts.any((account) => account['email'] == email);
    if (alreadyRemembered) return;

    rememberedAccounts.add({'email': email, 'password': password});
    _box.write('rememberedAccounts', rememberedAccounts);
  }

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

    Get.off(() => SignInScreen());
    AppSnackBar.success('Success',
        'Account created! Now you can sign in to enjoy our services. 🥳');
  }

  Future<void> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    // TODO: check if email not registered using oauth

    try {
      EasyLoading.show();
      Login? data = await _mobileApi.login(
        email: email,
        password: password,
      );

      _saveToken(data!.token);
      _saveUser(data.user);
      if (rememberMe) _addAccountToRemember(email, password);

      clog.info('Sign in success!');
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
      return;
    } finally {
      EasyLoading.dismiss();
    }

    Get.offAll(() => MainScreen());
  }

  Future<void> signInWithGoogle() async {
    try {
      EasyLoading.show();
      final Login? result = await _authService.emulateGoogleOauth();

      if (result != null) {
        _box.write('token', result.token);
        _saveUser(result.user);
        Get.offAll(() => MainScreen());
      } else
        throw Exception();
    } catch (e) {
      print(e);
      AppSnackBar.error('Error', 'Sign in with Google failed');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> signInWithGithub(BuildContext context) async {
    try {
      final Login? result = await _authService.emulateGithubOauth(context);

      if (result != null) {
        _box.write('token', result.token);
        _saveUser(result.user);
        Get.offAll(() => MainScreen());
      } else
        throw Exception();
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    } catch (e) {
      print(e);
      AppSnackBar.error('Error', 'Sign in with Github failed');
    } finally {
      EasyLoading.dismiss();
    }
  }

  signInWithFacebook() {
    AppSnackBar.error('Error', 'Unimplemented feature');
  }

  void signOut() {
    _mobileApi.logout();
    _box.remove('token');
    _box.remove('user');
    clog.info('Signin out success. Token removed.');
    Get.offAll(() => GetStartedScreen());
  }
}
