import 'package:flutter/cupertino.dart';
import 'package:patient_analytics_flutter/models/patient.dart';

class DoctorDashboardProvider extends ChangeNotifier {
  List<Patient> _patients = [];

  List<Patient> get patients => _patients;

  void populatePatients(List<Patient> patients) {
    _patients = patients;
  }
}
