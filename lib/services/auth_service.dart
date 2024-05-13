import 'package:color_log/color_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/login_type.dart';
import 'package:progmob_magical_destroyers/services/firebase_service.dart';

class AuthService {
  final _apiRequester = MoblieApiRequester();

  Future<Login?> simulateGoogleOauth() async {
    final String provider = 'google.com';

    // user select google account
    final UserCredential credential = await FirebaseService.signInWithGoogle();

    // check email exist in firestore
    clog.info('try to get user from firestore');
    Map<String, dynamic>? user = await FirebaseService.getUserMobileApiOauth(
      credential.user!.email!,
      provider,
    );

    // if not, register user in mobile api, then login
    if (user == null) {
      await FirebaseService.createUserMobileApiOauth(credential);
      await _apiRequester.register(
        email: credential.user!.email!,
        name: credential.user!.displayName!,
        password: credential.user!.email!,
      );
    }

    // login
    final Login? data = await _apiRequester.login(
      email: credential.user!.email!,
      password: credential.user!.email!,
    );

    return data;
  }
}
