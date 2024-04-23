class RegisterData {
  int id;
  String email;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  RegisterData({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
