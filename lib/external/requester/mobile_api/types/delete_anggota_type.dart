import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';

class DeleteAnggota {
  Anggota anggota;

  DeleteAnggota({required this.anggota});

  factory DeleteAnggota.fromJson(Map<String, dynamic> json) {
    return DeleteAnggota(
      anggota: Anggota.fromJson(json['anggota']),
    );
  }
}
