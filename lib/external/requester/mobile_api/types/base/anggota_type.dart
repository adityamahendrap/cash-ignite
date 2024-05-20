class Anggota {
  int id;
  int nomorInduk;
  String nama;
  String alamat;
  String tglLahir;
  String telepon;
  String? imageUrl;
  bool? statusAktif;

  Anggota({
    required this.id,
    required this.nomorInduk,
    required this.nama,
    required this.alamat,
    required this.tglLahir,
    required this.telepon,
    this.imageUrl,
    this.statusAktif,
  });

  factory Anggota.fromJson(Map<String, dynamic> json) {
    return Anggota(
      id: json['id'] ?? 0,
      nomorInduk: json['nomor_induk'] ?? 0,
      nama: json['nama'] ?? '',
      alamat: json['alamat'] ?? '',
      tglLahir: json['tgl_lahir'] ?? '',
      telepon: json['telepon'] ?? '',
      imageUrl: json['image_url'],
      statusAktif:
          json['status_aktif'] == null ? null : json['status_aktif'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nomor_induk'] = this.nomorInduk;
    data['nama'] = this.nama;
    data['alamat'] = this.alamat;
    data['tgl_lahir'] = this.tglLahir;
    data['telepon'] = this.telepon;
    data['image_url'] = this.imageUrl;
    data['status_aktif'] = this.statusAktif;
    return data;
  }
}
