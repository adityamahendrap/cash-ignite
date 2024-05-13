class Register {
  int id;
  String email;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  Register({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
