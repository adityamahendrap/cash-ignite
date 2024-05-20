class RememberedAccount {
  final String email;
  final String password;

  RememberedAccount({required this.email, required this.password});

  factory RememberedAccount.fromJson(Map<String, dynamic> json) {
    return RememberedAccount(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
