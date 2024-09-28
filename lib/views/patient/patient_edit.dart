import 'package:flutter/material.dart';
import 'package:patient_analytics_flutter/views/patient/forms/patient_form.dart';
import 'package:provider/provider.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';

class PatientEditPage extends StatelessWidget {
  const PatientEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientDetailsProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${provider.patient.firstName} ${provider.patient.lastName}',
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
          )
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            PatientForm(patient: provider.patient, onSubmit: (payload) {
              print(payload.firstName);
            })
          ],
        ),
      );
    });
  }
}
