import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/user_type.dart';

class CurrentUser {
  User user;
  String expired;

  CurrentUser({required this.user, required this.expired});

  factory CurrentUser.fromJson(Map<String, dynamic> json) {
    return CurrentUser(
      user: User.fromJson(json['user']),
      expired: json['expired'],
    );
  }
}
