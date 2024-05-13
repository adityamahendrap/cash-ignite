import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/user_type.dart';

class Login {
  String token;
  User user;

  Login({required this.token, required this.user});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
    };
  }
}
