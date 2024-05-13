import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';

class AddAnggota {
  Anggota anggota;

  AddAnggota({required this.anggota});

  factory AddAnggota.fromJson(Map<String, dynamic> json) {
    return AddAnggota(
      anggota: Anggota.fromJson(json['anggota']),
    );
  }
}

