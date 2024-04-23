import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';

class UpdateAnggotaData {
  Anggota anggota;

  UpdateAnggotaData({required this.anggota});

  factory UpdateAnggotaData.fromJson(Map<String, dynamic> json) {
    return UpdateAnggotaData(
      anggota: Anggota.fromJson(json['anggota']),
    );
  }
}
