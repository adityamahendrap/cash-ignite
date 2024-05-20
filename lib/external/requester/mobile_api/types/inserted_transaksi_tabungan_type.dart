class InsertedTransaksiTabungan {
  Data? data;
  Req? req;

  InsertedTransaksiTabungan({this.data, this.req});

  InsertedTransaksiTabungan.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    req = json['req'] != null ? new Req.fromJson(json['req']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.req != null) {
      data['req'] = this.req!.toJson();
    }
    return data;
  }
}

class Data {
  Tabungan? tabungan;

  Data({this.tabungan});

  Data.fromJson(Map<String, dynamic> json) {
    tabungan = json['tabungan'] != null
        ? new Tabungan.fromJson(json['tabungan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tabungan != null) {
      data['tabungan'] = this.tabungan!.toJson();
    }
    return data;
  }
}

class Tabungan {
  String? anggotaId;
  String? trxId;
  String? trxNominal;
  int? createdByUserid;
  String? trxTanggal;
  String? updatedAt;
  String? createdAt;
  int? id;

  Tabungan(
      {this.anggotaId,
      this.trxId,
      this.trxNominal,
      this.createdByUserid,
      this.trxTanggal,
      this.updatedAt,
      this.createdAt,
      this.id});

  Tabungan.fromJson(Map<String, dynamic> json) {
    anggotaId = json['anggota_id'];
    trxId = json['trx_id'];
    trxNominal = json['trx_nominal'];
    createdByUserid = json['created_by_userid'];
    trxTanggal = json['trx_tanggal'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anggota_id'] = this.anggotaId;
    data['trx_id'] = this.trxId;
    data['trx_nominal'] = this.trxNominal;
    data['created_by_userid'] = this.createdByUserid;
    data['trx_tanggal'] = this.trxTanggal;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class Req {
  String? anggotaId;
  String? trxId;
  String? trxNominal;
  int? createdByUserid;
  String? trxTanggal;

  Req(
      {this.anggotaId,
      this.trxId,
      this.trxNominal,
      this.createdByUserid,
      this.trxTanggal});

  Req.fromJson(Map<String, dynamic> json) {
    anggotaId = json['anggota_id'];
    trxId = json['trx_id'];
    trxNominal = json['trx_nominal'];
    createdByUserid = json['created_by_userid'];
    trxTanggal = json['trx_tanggal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anggota_id'] = this.anggotaId;
    data['trx_id'] = this.trxId;
    data['trx_nominal'] = this.trxNominal;
    data['created_by_userid'] = this.createdByUserid;
    data['trx_tanggal'] = this.trxTanggal;
    return data;
  }
}
