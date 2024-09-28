import 'dart:convert';

import 'package:patient_analytics_flutter/models/patient.dart';

class PatientPayload {
  final Patient? patient;

  late String email;
  late DateTime dateOfBirth;
  late String gender;
  late String firstName;
  late String lastName;
  late String address;

  PatientPayload({this.patient}) {
    email = patient?.email ?? '';
    dateOfBirth = patient?.dateOfBirth ?? DateTime.now();
    gender = patient?.gender ?? '';
    firstName = patient?.firstName ?? '';
    lastName = patient?.lastName ?? '';
    address = patient?.address ?? '';
  }

  String toJson() {
    return jsonEncode({
      'email': email,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
    });
  }
}
