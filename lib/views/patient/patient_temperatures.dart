import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:patient_analytics_flutter/extensions/text.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_temperature.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_temperature_payload.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/services/api_service.dart';
import 'package:patient_analytics_flutter/views/patient/forms/patient_metrics_form_container.dart';
import 'package:patient_analytics_flutter/views/patient/forms/patient_temperature_form.dart';
import 'package:patient_analytics_flutter/views/patient/patient_scaffold.dart';
import 'package:patient_analytics_flutter/views/patient/tables/patient_temperatures_table.dart';

class PatientTemperaturesPage extends StatefulWidget {
  const PatientTemperaturesPage({super.key, required this.id});

  final String id;

  @override
  State<PatientTemperaturesPage> createState() => _PatientTemperaturesState();
}

class _PatientTemperaturesState extends State<PatientTemperaturesPage> {
  List<PatientTemperature>? _currentEntriesState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final ApiService apiService = Get.put(ApiService());

      final patientId = int.tryParse(widget.id);

      if (patientId != null) {
        final result = await apiService.getPatientTemperatures(patientId);

        result.when((data) {
          setState(() => _currentEntriesState = data);
        }, (error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PatientDetailsProvider>();

    final localisations = AppLocalizations.of(context)!;

    final ApiService apiService = Get.put(ApiService());

    void onSubmit(PatientTemperaturePayload payload) async {
      final result = await apiService.addPatientTemperature(
        int.parse(widget.id),
        payload,
      );

      result.when((data) {
        provider.addTemperatureEntry(data);
        _currentEntriesState?.insert(0, data);
        Navigator.pop(context);
      }, (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }

    void revealEntryForm() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return PatientMetricsFormContainer(
            form: PatientTemperatureForm(onSubmit: onSubmit),
          );
        },
      );
    }

    return PatientScaffold(
      id: widget.id,
      provider: provider,
      appBar: (patient) {
        return AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${patient.firstName} ${patient.lastName}',
                  style: context.title.navHeader,
                ),
                Text(
                  localisations.title_temperature,
                  style: context.title.navSecondary,
                ),
              ],
            ),
          ),
        );
      },
      body: (patient) => ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          PatientTemperaturesTable(
            entries: _currentEntriesState ?? provider.temperatures,
          ),
        ],
      ),
      floatingActionButton: (_) => FloatingActionButton(
        onPressed: revealEntryForm,
        shape: const CircleBorder(),
        tooltip: localisations.button_entry_create,
        child: const Icon(CupertinoIcons.plus),
      ),
    );
  }
}
