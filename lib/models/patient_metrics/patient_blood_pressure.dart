import 'package:patient_analytics_flutter/models/user.dart';

class PatientBloodPressure {
  final int id;
  final int patientId;
  final int doctorId;
  final DateTime dateCreated;
  final String bloodPressureSystolicFormatted;
  final String bloodPressureDiastolicFormatted;
  final String status;
  final User? doctor;

  const PatientBloodPressure({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.dateCreated,
    required this.bloodPressureSystolicFormatted,
    required this.bloodPressureDiastolicFormatted,
    required this.status,
    this.doctor,
  });

  factory PatientBloodPressure.fromJson(Map<String, dynamic> responseBody) {
    return switch (responseBody) {
      {
        'id': int id,
        'patientId': int patientId,
        'doctorId': int doctorId,
        'dateCreated': String dateCreated,
        'bloodPressureSystolicFormatted': String bloodPressureSystolicFormatted,
        'bloodPressureDiastolicFormatted': String bloodPressureDiastolicFormatted,
        'status': String status,
        'doctor': Map<String, dynamic>? doctor,
      } =>
        PatientBloodPressure(
          id: id,
          patientId: patientId,
          doctorId: doctorId,
          dateCreated: DateTime.parse(dateCreated),
          bloodPressureSystolicFormatted: bloodPressureSystolicFormatted,
          bloodPressureDiastolicFormatted: bloodPressureDiastolicFormatted,
          status: status,
          doctor: (doctor != null) ? User.fromJson(doctor) : null,
        ),
      _ =>
        throw const FormatException('Failed to convert PatientBloodPressure'),
    };
  }
}
