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
      id: json['id'],
      nomorInduk: json['nomor_induk'],
      nama: json['nama'],
      alamat: json['alamat'],
      tglLahir: json['tgl_lahir'],
      telepon: json['telepon'],
      imageUrl: json['image_url'],
      statusAktif: json['status_aktif'] == 1 ? true : false,
    );
  }
}
