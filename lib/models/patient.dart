class Patient {
  final int id;
  final int doctorId;
  final DateTime dateOfBirth;
  final String gender;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? address;

  const Patient({
    required this.id,
    required this.doctorId,
    required this.dateOfBirth,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
  });

  factory Patient.fromJson(Map<String, dynamic> responseBody) {
    return switch (responseBody) {
      {
        'id': int id,
        'doctorId': int doctorId,
        'dateOfBirth': String dateOfBirth,
        'gender': String gender,
        'firstName': String? firstName,
        'lastName': String? lastName,
        'email': String email,
        'address': String? address,
      } =>
        Patient(
          id: id,
          doctorId: doctorId,
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
