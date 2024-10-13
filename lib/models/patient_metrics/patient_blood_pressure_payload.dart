import 'dart:convert';

class PatientBloodPressurePayload {
  double bloodPressureSystolic = 0.0;
  double bloodPressureDiastolic = 0.0;

  String toJson() {
    return jsonEncode({
      'bloodPressureSystolic': bloodPressureSystolic,
      'bloodPressureDiastolic': bloodPressureDiastolic,
    });
  }
}
