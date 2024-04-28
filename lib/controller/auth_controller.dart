import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/login_rype.dart';
import 'package:progmob_magical_destroyers/screens/main/main_screen.dart';
import 'package:progmob_magical_destroyers/service/auth_service.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';

class AuthController {
  final AuthService _authService = AuthService();
  final GetStorage _box = GetStorage();

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
}
