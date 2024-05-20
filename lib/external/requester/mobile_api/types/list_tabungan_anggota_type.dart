class ListTabunganAnggota {
  String? anggotaId;
  List<Tabungan>? tabungan;

  ListTabunganAnggota({this.anggotaId, this.tabungan});

  ListTabunganAnggota.fromJson(Map<String, dynamic> json) {
    anggotaId = json['anggota_id'];
    if (json['tabungan'] != null) {
      tabungan = <Tabungan>[];
      json['tabungan'].forEach((v) {
        tabungan!.add(new Tabungan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anggota_id'] = this.anggotaId;
    if (this.tabungan != null) {
      data['tabungan'] = this.tabungan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tabungan {
  int? id;
  String? trxTanggal;
  int? trxId;
  int? trxNominal;

  Tabungan({this.id, this.trxTanggal, this.trxId, this.trxNominal});

  Tabungan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trxTanggal = json['trx_tanggal'];
    trxId = json['trx_id'];
    trxNominal = json['trx_nominal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trx_tanggal'] = this.trxTanggal;
    data['trx_id'] = this.trxId;
    data['trx_nominal'] = this.trxNominal;
    return data;
  }
}
