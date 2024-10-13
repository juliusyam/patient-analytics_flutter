import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:patient_analytics_flutter/extensions/text.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_height.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_height_payload.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/services/api_service.dart';
import 'package:patient_analytics_flutter/views/patient/forms/patient_height_form.dart';
import 'package:patient_analytics_flutter/views/patient/forms/patient_metrics_form_container.dart';
import 'package:patient_analytics_flutter/views/patient/patient_scaffold.dart';
import 'package:patient_analytics_flutter/views/patient/tables/patient_heights_table.dart';

class PatientHeightsPage extends StatefulWidget {
  const PatientHeightsPage({super.key, required this.id});

  final String id;

  @override
  State<PatientHeightsPage> createState() => _PatientHeightsState();
}

class _PatientHeightsState extends State<PatientHeightsPage> {
  List<PatientHeight>? _currentEntriesState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final ApiService apiService = Get.put(ApiService());

      final patientId = int.tryParse(widget.id);

      if (patientId != null) {
        final result = await apiService.getPatientHeights(patientId);

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

    void onSubmit(PatientHeightPayload payload) async {
      final result = await apiService.addPatientHeight(
        int.parse(widget.id),
        payload,
      );

      result.when((data) {
        provider.addHeightEntry(data);
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
            form: PatientHeightForm(onSubmit: onSubmit),
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
                  localisations.title_height,
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
          PatientHeightsTable(
            entries: _currentEntriesState ?? provider.heights,
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
