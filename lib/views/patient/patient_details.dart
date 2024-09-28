import 'package:flutter/material.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/views/patient/patient_hero.dart';
import 'package:provider/provider.dart';

class PatientDetailsPage extends StatelessWidget {
  const PatientDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientDetailsProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('${provider.patient.firstName} ${provider.patient.lastName}'),
        ),
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(10.0),
          color: Colors.cyan.shade50,
          child: PatientHero(patient: provider.patient),
        ),
      );
    });
  }
}
