class MasterJenisTransaksi {
  List<Jenistransaksi>? jenistransaksi;

  MasterJenisTransaksi({this.jenistransaksi});

  MasterJenisTransaksi.fromJson(Map<String, dynamic> json) {
    if (json['jenistransaksi'] != null) {
      jenistransaksi = <Jenistransaksi>[];
      json['jenistransaksi'].forEach((v) {
        jenistransaksi!.add(new Jenistransaksi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jenistransaksi != null) {
      data['jenistransaksi'] =
          this.jenistransaksi!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jenistransaksi {
  int? id;
  String? trxName;
  int? trxMultiply;

  Jenistransaksi({this.id, this.trxName, this.trxMultiply});

  Jenistransaksi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trxName = json['trx_name'];
    trxMultiply = json['trx_multiply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trx_name'] = this.trxName;
    data['trx_multiply'] = this.trxMultiply;
    return data;
  }
}
