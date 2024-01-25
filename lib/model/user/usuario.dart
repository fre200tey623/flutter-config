class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? firebaseToken;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.role,
      this.firebaseToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      firebaseToken: json['firebaseToken'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        'firebaseToken': firebaseToken,
      };
}
