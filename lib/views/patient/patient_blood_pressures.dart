import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/views/patient/tables/patient_blood_pressures_table.dart';
import 'package:provider/provider.dart';

class PatientBloodPressuresPage extends StatelessWidget {
  PatientBloodPressuresPage({super.key});

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
                'Blood Pressure Records',
                style: TextStyle(
                  color: Colors.cyan.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        body: PatientBloodPressuresTable(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          tooltip: 'Edit',
          child: const Icon(CupertinoIcons.plus),
        ),
      );
    });
  }
}
