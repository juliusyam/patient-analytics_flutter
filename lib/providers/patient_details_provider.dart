
import 'package:flutter/material.dart';
import 'package:patient_analytics_flutter/models/patient.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_blood_pressure.dart';

class PatientDetailsProvider extends ChangeNotifier {
  PatientDetailsProvider({required this.patient});

  // TODO: Check if this value should be final
  Patient patient;

  List<PatientBloodPressure> _bloodPressures = [];
  List<PatientBloodPressure> get bloodPressures => _bloodPressures;

  void populateMetrics(List<PatientBloodPressure> bloodPressures) {
    _bloodPressures = bloodPressures;
    notifyListeners();
  }

  void updatePatientDetails(Patient updatedPatient) {
    patient = updatedPatient;
    notifyListeners();
  }
}
