import 'package:patient_analytics_flutter/models/patient_metrics/patient_blood_pressure.dart';

class PatientWithMetrics {
  final List<PatientBloodPressure> bloodPressures;

  const PatientWithMetrics({
    required this.bloodPressures,
  });

  factory PatientWithMetrics.fromJson(Map<String, dynamic> responseBody) {
    return switch (responseBody) {
      {
        'bloodPressures': List bloodPressures,
      } =>
        PatientWithMetrics(
            bloodPressures: bloodPressures
                .map((item) => PatientBloodPressure.fromJson(item))
                .toList()),
      _ =>
        throw const FormatException('Failed to convert Patient with Metrics'),
    };
  }
}
