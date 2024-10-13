import 'package:patient_analytics_flutter/models/user.dart';

class PatientWeight {
  final int id;
  final int patientId;
  final int doctorId;
  final DateTime dateCreated;
  final String weightKgFormatted;
  final String weightStFormatted;
  final String weightLbFormatted;
  final User? doctor;

  const PatientWeight({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.dateCreated,
    required this.weightKgFormatted,
    required this.weightStFormatted,
    required this.weightLbFormatted,
    this.doctor,
  });

  factory PatientWeight.fromJson(Map<String, dynamic> responseBody) {
    return switch (responseBody) {
      {
        'id': int id,
        'patientId': int patientId,
        'doctorId': int doctorId,
        'dateCreated': String dateCreated,
        'weightKgFormatted': String weightKgFormatted,
        'weightStFormatted': String weightStFormatted,
        'weightLbFormatted': String weightLbFormatted,
        'doctor': Map<String, dynamic>? doctor,
      } =>
        PatientWeight(
          id: id,
          patientId: patientId,
          doctorId: doctorId,
          dateCreated: DateTime.parse(dateCreated),
          weightKgFormatted: weightKgFormatted,
          weightStFormatted: weightStFormatted,
          weightLbFormatted: weightLbFormatted,
          doctor: (doctor != null) ? User.fromJson(doctor) : null,
        ),
      _ => throw const FormatException('Failed to convert PatientWeight'),
    };
  }
}
