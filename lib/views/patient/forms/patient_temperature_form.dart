import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:patient_analytics_flutter/components/form/double_form_field.dart';
import 'package:patient_analytics_flutter/extensions/string.dart';
import 'package:patient_analytics_flutter/models/enums/unit.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_temperature_payload.dart';

class PatientTemperatureForm extends StatefulWidget {
  const PatientTemperatureForm({super.key, required this.onSubmit});

  final ValueChanged<PatientTemperaturePayload> onSubmit;

  @override
  State<PatientTemperatureForm> createState() => _PatientTemperatureFormState();
}

class _PatientTemperatureFormState extends State<PatientTemperatureForm> {
  final formKey = GlobalKey<FormState>();

  final payload = PatientTemperaturePayload();

  @override
  Widget build(BuildContext context) {
    final localisations = AppLocalizations.of(context)!;

    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          DoubleFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: localisations.form_temperature_title,
            ),
            initialValue: payload.temperature,
            min: 1,
            onValidChanged: (value) {
              payload.temperature = value;
            },
            fieldHintText: localisations.form_temperature_validation,
          ),
          const SizedBox(height: 10),
          DropdownMenu<TemperatureUnit>(
            initialSelection: payload.unit,
            dropdownMenuEntries: TemperatureUnit.values.map((value) {
              return DropdownMenuEntry(
                value: value,
                label: value.toLocalizedString(localisations),
              );
            }).toList(),
            onSelected: (value) {
              if (value != null) payload.unit = value;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.onSubmit(payload);
              }
            },
            child: Text(localisations.button_reading_add),
          ),
        ],
      ),
    );
  }
}
