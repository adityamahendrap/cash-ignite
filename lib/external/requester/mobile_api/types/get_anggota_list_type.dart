import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';

class GetAnggotaList {
  final List<Anggota> anggotaList;

  GetAnggotaList({
    required this.anggotaList,
  });

  factory GetAnggotaList.fromJson(Map<String, dynamic> json) {
    List<Anggota> anggotaList = [];
    for (var anggota in json['anggotas']) {
      anggotaList.add(Anggota.fromJson(anggota));
    }
    return GetAnggotaList(
      anggotaList: anggotaList,
    );
  }
}
