import 'package:patient_analytics_flutter/models/patient.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_blood_pressure.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_height.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_temperature.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_weight.dart';

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
  final List<PatientHeight> heights;
  final List<PatientTemperature> temperatures;
  final List<PatientWeight> weights;

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
    required this.heights,
    required this.temperatures,
    required this.weights,
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
        'heights': List heights,
        'temperatures': List temperatures,
        'weights': List weights,
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
              .toList(),
          heights: heights.map((item) => PatientHeight.fromJson(item)).toList(),
          temperatures: temperatures
              .map((item) => PatientTemperature.fromJson(item))
              .toList(),
          weights: weights.map((item) => PatientWeight.fromJson(item)).toList(),
        ),
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
