import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:patient_analytics_flutter/models/patient_payload.dart';
import 'package:patient_analytics_flutter/providers/doctor_dashboard_provider.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/services/api_service.dart';
import 'package:patient_analytics_flutter/views/patient/forms/patient_form.dart';

class PatientEditPage extends StatelessWidget {
  const PatientEditPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = Get.put(ApiService());

    final patientDetailsProvider = context.watch<PatientDetailsProvider>();

    final doctorDashboardProvider = context.watch<DoctorDashboardProvider>();

    Future<void> onSubmit(PatientPayload patientPayload) async {
      final result =
          await apiService.editPatient(int.parse(id), patientPayload);

      result.when((data) {
        patientDetailsProvider.updatePatientDetails(data);
        doctorDashboardProvider.updatePatient(data);
        Navigator.pop(context);
      }, (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${patientDetailsProvider.patient.firstName} ${patientDetailsProvider.patient.lastName}',
              ),
              Text(
                'Edit Patient Information',
                style: TextStyle(
                  color: Colors.cyan.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          )),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          PatientForm(
            patient: patientDetailsProvider.patient,
            onSubmit: onSubmit,
          ),
        ],
      ),
    );
  }
}
