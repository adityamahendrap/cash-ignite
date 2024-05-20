import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';

class AnggotaList {
  final List<Anggota> anggotaList;

  AnggotaList({
    required this.anggotaList,
  });

  factory AnggotaList.fromJson(Map<String, dynamic> json) {
    List<Anggota> anggotaList = [];
    for (var anggota in json['anggotas']) {
      anggotaList.add(Anggota.fromJson(anggota));
    }
    return AnggotaList(
      anggotaList: anggotaList,
    );
  }
}
