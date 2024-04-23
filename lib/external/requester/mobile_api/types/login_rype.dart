import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/user_type.dart';

class LoginData {
  String token;
  User user;

  LoginData({required this.token, required this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
