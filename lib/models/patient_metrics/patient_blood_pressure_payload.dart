import 'dart:convert';

class PatientBloodPressurePayload {
  int bloodPressureSystolic = 0;
  int bloodPressureDiastolic = 0;

  String toJson() {
    return jsonEncode({
      'bloodPressureSystolic': bloodPressureSystolic,
      'bloodPressureDiastolic': bloodPressureDiastolic,
    });
  }
}
