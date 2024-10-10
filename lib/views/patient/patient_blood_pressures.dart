import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:patient_analytics_flutter/extensions/text.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_blood_pressure_payload.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/services/api_service.dart';
import 'package:patient_analytics_flutter/views/patient/forms/patient_blood_pressure_form.dart';
import 'package:patient_analytics_flutter/views/patient/tables/patient_blood_pressures_table.dart';

class PatientBloodPressuresPage extends StatelessWidget {
  const PatientBloodPressuresPage({super.key, required this.id});

  final String id;


  @override
  Widget build(BuildContext context) {
    final localisations = AppLocalizations.of(context)!;

    final provider = context.watch<PatientDetailsProvider>();

    final ApiService apiService = Get.put(ApiService());

    void onSubmit(PatientBloodPressurePayload payload) async {
      final result = await apiService.addPatientBloodPressure(
          int.parse(id), payload);

      result.when((data) {
        provider.addBloodPressureEntry(data);
        Navigator.pop(context);
      }, (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }

    void revealEntryForm() {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    PatientBloodPressureForm(onSubmit: onSubmit),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(localisations.button_close),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${provider.patient.firstName} ${provider.patient.lastName}',
                style: context.title.navHeader,
              ),
              Text(
                'Blood Pressure Records',
                style: context.title.navSecondary,
              ),
            ],
          ),
        ),
      ),
      body: PatientBloodPressuresTable(entries: provider.bloodPressures),
      floatingActionButton: FloatingActionButton(
        onPressed: revealEntryForm,
        shape: const CircleBorder(),
        tooltip: 'Edit',
        child: const Icon(CupertinoIcons.plus),
      ),
    );
  }
}
