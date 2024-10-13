import 'package:patient_analytics_flutter/models/user.dart';

class PatientTemperature {
  final int id;
  final int patientId;
  final int doctorId;
  final DateTime dateCreated;
  final String temperatureCelsiusFormatted;
  final String temperatureFahrenheitFormatted;
  final User? doctor;

  const PatientTemperature({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.dateCreated,
    required this.temperatureCelsiusFormatted,
    required this.temperatureFahrenheitFormatted,
    this.doctor,
  });

  factory PatientTemperature.fromJson(Map<String, dynamic> responseBody) {
    return switch (responseBody) {
      {
        'id': int id,
        'patientId': int patientId,
        'doctorId': int doctorId,
        'dateCreated': String dateCreated,
        'temperatureCelsiusFormatted': String temperatureCelsiusFormatted,
        'temperatureFahrenheitFormatted': String temperatureFahrenheitFormatted,
        'doctor': Map<String, dynamic>? doctor,
      } =>
        PatientTemperature(
          id: id,
          patientId: patientId,
          doctorId: doctorId,
          dateCreated: DateTime.parse(dateCreated),
          temperatureCelsiusFormatted: temperatureCelsiusFormatted,
          temperatureFahrenheitFormatted: temperatureFahrenheitFormatted,
          doctor: (doctor != null) ? User.fromJson(doctor) : null,
        ),
      _ => throw const FormatException('Failed to convert PatientTemperature'),
    };
  }
}
