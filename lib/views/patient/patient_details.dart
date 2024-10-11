import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patient_analytics_flutter/extensions/text.dart';
import 'package:patient_analytics_flutter/models/patient.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/views/patient/patient_hero.dart';
import 'package:patient_analytics_flutter/views/patient/patient_scaffold.dart';
import 'package:patient_analytics_flutter/views/patient/tables/patient_blood_pressures_table.dart';

class PatientDetailsPage extends StatelessWidget {
  const PatientDetailsPage({super.key, required this.id, this.initialPatient});

  final String id;
  final Patient? initialPatient;

  @override
  Widget build(BuildContext context) {
    final patientDetailsProvider = context.watch<PatientDetailsProvider>();

    return PatientScaffold(
      id: id,
      initialPatient: initialPatient,
      provider: patientDetailsProvider,
      appBar: (patient) {
        return AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            '${patient.firstName} ${patient.lastName}',
            style: context.title.navHeader,
          ),
        );
      },
      body: (patient) {
        return Column(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(10.0),
              color: Colors.cyan.shade50,
              child: PatientHero(patient: patient),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 2.0, color: Colors.cyan.shade100),
                color: Colors.cyan.shade50,
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: 0.05,
                    blurRadius: 7.0,
                    color: Colors.white70,
                  ),
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Text(
                    'Blood Pressure Records',
                    style: context.title.secondary,
                  ),
                  PatientBloodPressuresTable(
                    entries: patientDetailsProvider.bloodPressures,
                    limit: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Modular.to.pushNamed(
                          '/doctor-dashboard/patient/${patient.id}/blood-pressures');
                    },
                    child: const Text('View more'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      floatingActionButton: (patient) => FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('/doctor-dashboard/patient/${patient.id}/edit');
        },
        shape: const CircleBorder(),
        tooltip: 'Edit Patient',
        child: const Icon(CupertinoIcons.pencil),
      ),
    );
  }
}
