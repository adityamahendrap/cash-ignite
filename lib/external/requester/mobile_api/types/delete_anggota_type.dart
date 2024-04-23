import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';

class DeleteAnggotaData {
  Anggota anggota;

  DeleteAnggotaData({required this.anggota});

  factory DeleteAnggotaData.fromJson(Map<String, dynamic> json) {
    return DeleteAnggotaData(
      anggota: Anggota.fromJson(json['anggota']),
    );
  }
}
