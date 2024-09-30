import 'package:flutter/cupertino.dart';
import 'package:patient_analytics_flutter/models/patient.dart';

class DoctorDashboardProvider extends ChangeNotifier {
  List<Patient> _patients = [];

  List<Patient> get patients => _patients;

  void populatePatients(List<Patient> patients) {
    _patients = patients;
    notifyListeners();
  }

  void addPatient(Patient patient) {
    _patients.add(patient);
    notifyListeners();
  }

  void updatePatient(Patient patient) {
    var index = _patients.indexWhere((p) => p.id == patient.id);

    if (index >= 0) {
      _patients[index] = patient;
      notifyListeners();
    }
  }
}
