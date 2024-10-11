import 'package:flutter/cupertino.dart';
import 'package:patient_analytics_flutter/models/patient.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';

class PatientFetchContainer extends StatelessWidget {
  const PatientFetchContainer({
    super.key,
    required this.provider,
    required this.child,
    required this.initialPatient,
  });

  final PatientDetailsProvider provider;
  final Patient? initialPatient;
  final Widget Function(Patient patient) child;

  @override
  Widget build(BuildContext context) {
    Patient? currentPatientState = provider.patientOrNull ?? initialPatient;

    if (currentPatientState == null) return const Text('Fetching Patient...');

    return child(currentPatientState);
  }
}
