import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';

class GetAnggotaListData {
  final List<Anggota> anggotaList;

  GetAnggotaListData({
    required this.anggotaList,
  });

  factory GetAnggotaListData.fromJson(Map<String, dynamic> json) {
    List<Anggota> anggotaList = [];
    for (var anggota in json['anggotas']) {
      anggotaList.add(Anggota.fromJson(anggota));
    }
    return GetAnggotaListData(
      anggotaList: anggotaList,
    );
  }
}
