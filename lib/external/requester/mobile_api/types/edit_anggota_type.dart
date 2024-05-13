import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';

class UpdateAnggota {
  Anggota anggota;

  UpdateAnggota({required this.anggota});

  factory UpdateAnggota.fromJson(Map<String, dynamic> json) {
    return UpdateAnggota(
      anggota: Anggota.fromJson(json['anggota']),
    );
  }
}
