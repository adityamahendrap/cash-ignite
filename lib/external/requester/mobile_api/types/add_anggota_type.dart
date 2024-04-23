import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';

class AddAnggotaData {
  Anggota anggota;

  AddAnggotaData({required this.anggota});

  factory AddAnggotaData.fromJson(Map<String, dynamic> json) {
    return AddAnggotaData(
      anggota: Anggota.fromJson(json['anggota']),
    );
  }
}

