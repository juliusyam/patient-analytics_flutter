import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_analytics_flutter/models/patient_payload.dart';
import 'package:patient_analytics_flutter/providers/doctor_dashboard_provider.dart';
import 'package:patient_analytics_flutter/services/api_service.dart';
import 'package:patient_analytics_flutter/views/patient/forms/patient_form.dart';
import 'package:provider/provider.dart';

class PatientCreatePage extends StatelessWidget {
  const PatientCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = Get.put(ApiService());

    return Consumer<DoctorDashboardProvider>(builder: (context, provider, _) {

      Future<void> onSubmit(PatientPayload patientPayload) async {
        final result = await apiService.createPatient(patientPayload);

        result.when((data) {
          provider.addPatient(data);
          Navigator.pop(context);
        }, (error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
        });
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Create New Patient'),
            ],
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            PatientForm(onSubmit: onSubmit)
          ],
        ),
      );
    });
  }
}
