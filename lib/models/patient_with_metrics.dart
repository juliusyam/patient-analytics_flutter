import 'package:patient_analytics_flutter/models/patient.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_blood_pressure.dart';

class PatientWithMetrics {
  final int id;
  final int doctorId;
  final DateTime dateOfBirth;
  final String gender;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? address;
  final List<PatientBloodPressure> bloodPressures;

  const PatientWithMetrics({
    required this.id,
    required this.doctorId,
    required this.dateOfBirth,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.bloodPressures,
  });

  factory PatientWithMetrics.fromJson(Map<String, dynamic> responseBody) {
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
        'bloodPressures': List bloodPressures,
      } =>
        PatientWithMetrics(
            id: id,
            doctorId: doctorId,
            dateOfBirth: DateTime.parse(dateOfBirth),
            gender: gender,
            firstName: firstName,
            lastName: lastName,
            email: email,
            address: address,
            bloodPressures: bloodPressures
                .map((item) => PatientBloodPressure.fromJson(item))
                .toList()),
      _ =>
        throw const FormatException('Failed to convert Patient with Metrics'),
    };
  }

  Patient extractPatient() {
    return Patient(
      id: id,
      doctorId: doctorId,
      dateOfBirth: dateOfBirth,
      gender: gender,
      firstName: firstName,
      lastName: lastName,
      email: email,
      address: address,
    );
  }
}
