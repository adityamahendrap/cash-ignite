import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/user_type.dart';

class GetCurrentUserData {
  User user;
  String expired;

  GetCurrentUserData({required this.user, required this.expired});

  factory GetCurrentUserData.fromJson(Map<String, dynamic> json) {
    return GetCurrentUserData(
      user: User.fromJson(json['user']),
      expired: json['expired'],
    );
  }
}
