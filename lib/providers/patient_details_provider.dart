import 'package:flutter/material.dart';
import 'package:patient_analytics_flutter/models/patient.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_blood_pressure.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_height.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_temperature.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_weight.dart';

class PatientDetailsProvider extends ChangeNotifier {
  PatientDetailsProvider();

  Patient? _patient;
  List<PatientBloodPressure> _bloodPressures = [];
  List<PatientHeight> _heights = [];
  List<PatientTemperature> _temperatures = [];
  List<PatientWeight> _weights = [];

  Patient? get patientOrNull => _patient;

  List<PatientBloodPressure> get bloodPressures => _bloodPressures;

  List<PatientHeight> get heights => _heights;

  List<PatientTemperature> get temperatures => _temperatures;

  List<PatientWeight> get weights => _weights;

  void populateMetrics(
    List<PatientBloodPressure> bloodPressures,
    List<PatientHeight> heights,
    List<PatientTemperature> temperatures,
    List<PatientWeight> weights,
  ) {
    _bloodPressures = bloodPressures;
    _heights = heights;
    _temperatures = temperatures;
    _weights = weights;
    notifyListeners();
  }

  void addBloodPressureEntry(PatientBloodPressure entry) {
    _bloodPressures.insert(0, entry);
    notifyListeners();
  }

  void addHeightEntry(PatientHeight entry) {
    _heights.insert(0, entry);
    notifyListeners();
  }

  void addTemperatureEntry(PatientTemperature entry) {
    _temperatures.insert(0, entry);
    notifyListeners();
  }

  void addWeightEntry(PatientWeight entry) {
    _weights.insert(0, entry);
    notifyListeners();
  }

  void updatePatientDetails(Patient updatedPatient) {
    _patient = updatedPatient;
    notifyListeners();
  }
}
