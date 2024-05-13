import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';

class GetAnggota {
  Anggota anggota;

  GetAnggota({required this.anggota});

  factory GetAnggota.fromJson(Map<String, dynamic> json) {
    return GetAnggota(
      anggota: Anggota.fromJson(json['anggota']),
    );
  }
}

