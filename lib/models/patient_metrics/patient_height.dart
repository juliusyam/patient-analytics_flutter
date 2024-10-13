import 'package:patient_analytics_flutter/models/user.dart';

class PatientHeight {
  final int id;
  final int patientId;
  final int doctorId;
  final DateTime dateCreated;
  final String heightCmFormatted;
  final String heightInFormatted;
  final String heightFtFormatted;
  final User? doctor;

  const PatientHeight({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.dateCreated,
    required this.heightCmFormatted,
    required this.heightInFormatted,
    required this.heightFtFormatted,
    this.doctor,
  });

  factory PatientHeight.fromJson(Map<String, dynamic> responseBody) {
    return switch (responseBody) {
      {
        'id': int id,
        'patientId': int patientId,
        'doctorId': int doctorId,
        'dateCreated': String dateCreated,
        'heightCmFormatted': String heightCmFormatted,
        'heightInFormatted': String heightInFormatted,
        'heightFtFormatted': String heightFtFormatted,
        'doctor': Map<String, dynamic>? doctor,
      } =>
        PatientHeight(
          id: id,
          patientId: patientId,
          doctorId: doctorId,
          dateCreated: DateTime.parse(dateCreated),
          heightCmFormatted: heightCmFormatted,
          heightInFormatted: heightInFormatted,
          heightFtFormatted: heightFtFormatted,
          doctor: (doctor != null) ? User.fromJson(doctor) : null,
        ),
      _ => throw const FormatException('Failed to convert PatientHeight'),
    };
  }
}
