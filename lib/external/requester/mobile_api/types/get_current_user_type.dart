import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/user_type.dart';

class GetCurrentUser {
  User user;
  String expired;

  GetCurrentUser({required this.user, required this.expired});

  factory GetCurrentUser.fromJson(Map<String, dynamic> json) {
    return GetCurrentUser(
      user: User.fromJson(json['user']),
      expired: json['expired'],
    );
  }
}
