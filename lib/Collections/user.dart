class AppUser {
  final String id;
  final String name;
  final String email;
  final String matricula;
  final String role;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.matricula,
    required this.role,
  });

  factory AppUser.fromMap(String id, Map<String, dynamic> data) {
    return AppUser(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      matricula: data['matricula'] ?? '',
      role: data['role'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'matricula': matricula,
      'role': role,
    };
  }
}