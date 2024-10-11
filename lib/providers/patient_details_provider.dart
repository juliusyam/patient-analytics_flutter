import 'package:flutter/material.dart';
import 'package:patient_analytics_flutter/models/patient.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_blood_pressure.dart';

class PatientDetailsProvider extends ChangeNotifier {
  PatientDetailsProvider();

  Patient? _patient;

  Patient? get patientOrNull => _patient;

  Patient get patient => (_patient != null)
      ? _patient!
      : throw const FormatException('Patient is not defined');

  List<PatientBloodPressure> _bloodPressures = [];

  List<PatientBloodPressure> get bloodPressures => _bloodPressures;

  void populateMetrics(List<PatientBloodPressure> bloodPressures) {
    _bloodPressures = bloodPressures;
    notifyListeners();
  }

  void addBloodPressureEntry(PatientBloodPressure entry) {
    _bloodPressures.add(entry);
    notifyListeners();
  }

  void updatePatientDetails(Patient updatedPatient) {
    _patient = updatedPatient;
    notifyListeners();
  }
}
