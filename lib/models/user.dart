class User {
  final int id;
  final String username;
  final String role;
  final DateTime dateOfBirth;
  final String gender;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? address;

  const User({
    required this.id,
    required this.username,
    required this.role,
    required this.dateOfBirth,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> responseBody) {
    return switch (responseBody) {
      {
        'id': int id,
        'username': String username,
        'role': String role,
        'dateOfBirth': String dateOfBirth,
        'gender': String gender,
        'firstName': String? firstName,
        'lastName': String? lastName,
        'email': String email,
        'address': String? address,
      } =>
        User(
          id: id,
          username: username,
          role: role,
          dateOfBirth: DateTime.parse(dateOfBirth),
          gender: gender,
          firstName: firstName,
          lastName: lastName,
          email: email,
          address: address,
        ),
      _ => throw const FormatException('Failed to convert User'),
    };
  }
}
