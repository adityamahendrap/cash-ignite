class TransactionType {
  final int id;
  final String name;
  final String imageUrl;
  final int trxMultiply;
  final String description = "";

  TransactionType({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.trxMultiply,
  });
}

final List<TransactionType> transactionTypes = [
  TransactionType(
    id: 1,
    name: "Saldo Awal",
    imageUrl: "assets/initial.png",
    trxMultiply: 1,
  ),
  TransactionType(
    id: 2,
    name: "Simpanan",
    imageUrl: "assets/simpanan.png",
    trxMultiply: 1,
  ),
  TransactionType(
    id: 3,
    name: "Penarikan",
    imageUrl: "assets/penarikan.png",
    trxMultiply: -1,
  ),
  // TransactionType(
  //   id: 4,
  //   name: "Bunga Simpanan",
  //   imageUrl: "assets/bunga.png",
  //   trxMultiply: 1,
  // ),
  TransactionType(
    id: 5,
    name: "Koreksi Penambahan",
    imageUrl: "assets/koreksi.png",
    trxMultiply: 1,
  ),
  TransactionType(
    id: 6,
    name: "Koreksi Pengurangan",
    imageUrl: "assets/koreksi.png",
    trxMultiply: -1,
  ),
];