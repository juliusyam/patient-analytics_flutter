class PatientBloodPressure {
  final int id;
  final int patientId;
  final int doctorId;
  final DateTime dateCreated;
  final double bloodPressureSystolic;
  final double bloodPressureDiastolic;
  final String status;

  const PatientBloodPressure({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.dateCreated,
    required this.bloodPressureSystolic,
    required this.bloodPressureDiastolic,
    required this.status,
  });

  factory PatientBloodPressure.fromJson(Map<String, dynamic> responseBody) {
    return switch (responseBody) {
      {
        'id': int id,
        'patientId': int patientId,
        'doctorId': int doctorId,
        'dateCreated': String dateCreated,
        'bloodPressureSystolic': double bloodPressureSystolic,
        'bloodPressureDiastolic': double bloodPressureDiastolic,
        'status': String status,
      } =>
        PatientBloodPressure(
          id: id,
          patientId: patientId,
          doctorId: doctorId,
          dateCreated: DateTime.parse(dateCreated),
          bloodPressureSystolic: bloodPressureSystolic,
          bloodPressureDiastolic: bloodPressureDiastolic,
          status: status,
        ),
      _ =>
        throw const FormatException('Failed to convert PatientBloodPressure'),
    };
  }
}
