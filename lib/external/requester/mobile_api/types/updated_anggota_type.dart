import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';

class UpdatedAnggota {
  Anggota? anggota;

  UpdatedAnggota({this.anggota});

  UpdatedAnggota.fromJson(Map<String, dynamic> json) {
    anggota =
        json['anggota'] != null ? new Anggota.fromJson(json['anggota']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.anggota != null) {
      data['anggota'] = this.anggota!.toJson();
    }
    return data;
  }
}