import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:patient_analytics_flutter/components/form/double_form_field.dart';
import 'package:patient_analytics_flutter/components/form/integer_form_field.dart';
import 'package:patient_analytics_flutter/extensions/string.dart';
import 'package:patient_analytics_flutter/models/enums/unit.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_height_payload.dart';

class PatientHeightForm extends StatefulWidget {
  const PatientHeightForm({super.key, required this.onSubmit});

  final ValueChanged<PatientHeightPayload> onSubmit;

  @override
  State<PatientHeightForm> createState() => _PatientHeightFormState();
}

class _PatientHeightFormState extends State<PatientHeightForm> {
  final formKey = GlobalKey<FormState>();

  final payload = PatientHeightPayload();

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
              labelText: localisations.form_height_title,
            ),
            initialValue: payload.height,
            min: 1,
            onValidChanged: (value) {
              payload.height = value;
            },
            fieldHintText: localisations.form_height_validation,
          ),
          const SizedBox(height: 10),
          DropdownMenu<HeightUnit>(
            initialSelection: payload.unit,
            dropdownMenuEntries: HeightUnit.values.map((value) {
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
