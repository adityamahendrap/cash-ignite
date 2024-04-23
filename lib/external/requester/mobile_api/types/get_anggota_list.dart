import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';

class GetAnggotaData {
  Anggota anggota;

  GetAnggotaData({required this.anggota});

  factory GetAnggotaData.fromJson(Map<String, dynamic> json) {
    return GetAnggotaData(
      anggota: Anggota.fromJson(json['anggota']),
    );
  }
}

