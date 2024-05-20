import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';

class DeletedAnggota {
  Anggota? anggota;

  DeletedAnggota({this.anggota});

  DeletedAnggota.fromJson(Map<String, dynamic> json) {
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