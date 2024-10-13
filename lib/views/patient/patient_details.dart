import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patient_analytics_flutter/extensions/text.dart';
import 'package:patient_analytics_flutter/models/patient.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/views/patient/patient_hero.dart';
import 'package:patient_analytics_flutter/views/patient/patient_scaffold.dart';
import 'package:patient_analytics_flutter/views/patient/tables/patient_blood_pressures_table.dart';
import 'package:patient_analytics_flutter/views/patient/tables/patient_heights_table.dart';
import 'package:patient_analytics_flutter/views/patient/tables/patient_metrics_table_container.dart';
import 'package:patient_analytics_flutter/views/patient/tables/patient_temperatures_table.dart';
import 'package:patient_analytics_flutter/views/patient/tables/patient_weights_table.dart';

class PatientDetailsPage extends StatelessWidget {
  const PatientDetailsPage({super.key, required this.id, this.initialPatient});

  final String id;
  final Patient? initialPatient;

  @override
  Widget build(BuildContext context) {
    final patientDetailsProvider = context.watch<PatientDetailsProvider>();

    final localisations = AppLocalizations.of(context)!;

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
        return ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(10.0),
              color: Colors.cyan.shade50,
              child: PatientHero(patient: patient),
            ),
            PatientMetricsTableContainer(
              title: localisations.title_blood_pressure,
              table: PatientBloodPressuresTable(
                entries: patientDetailsProvider.bloodPressures,
                limit: 5,
              ),
              onPressed: () {
                Modular.to.pushNamed(
                    '/doctor-dashboard/patient/${patient.id}/blood-pressures');
              },
            ),
            PatientMetricsTableContainer(
              title: localisations.title_height,
              table: PatientHeightsTable(
                entries: patientDetailsProvider.heights,
                limit: 5,
              ),
              onPressed: () {
                Modular.to.pushNamed(
                    '/doctor-dashboard/patient/${patient.id}/heights');
              },
            ),
            PatientMetricsTableContainer(
              title: localisations.title_temperature,
              table: PatientTemperaturesTable(
                entries: patientDetailsProvider.temperatures,
                limit: 5,
              ),
              onPressed: () {
                Modular.to.pushNamed(
                    '/doctor-dashboard/patient/${patient.id}/temperatures');
              },
            ),
            PatientMetricsTableContainer(
              title: localisations.title_weight,
              table: PatientWeightsTable(
                entries: patientDetailsProvider.weights,
                limit: 5,
              ),
              onPressed: () {
                Modular.to.pushNamed(
                    '/doctor-dashboard/patient/${patient.id}/weights');
              },
            ),
          ],
        );
      },
      floatingActionButton: (patient) => FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('/doctor-dashboard/patient/${patient.id}/edit');
        },
        shape: const CircleBorder(),
        tooltip: localisations.button_patient_update,
        child: const Icon(CupertinoIcons.pencil),
      ),
    );
  }
}
