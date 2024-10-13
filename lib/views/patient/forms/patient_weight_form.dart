import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:patient_analytics_flutter/components/form/double_form_field.dart';
import 'package:patient_analytics_flutter/extensions/string.dart';
import 'package:patient_analytics_flutter/models/enums/unit.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_weight_payload.dart';

class PatientWeightForm extends StatefulWidget {
  const PatientWeightForm({super.key, required this.onSubmit});

  final ValueChanged<PatientWeightPayload> onSubmit;

  @override
  State<PatientWeightForm> createState() => _PatientWeightFormState();
}

class _PatientWeightFormState extends State<PatientWeightForm> {
  final formKey = GlobalKey<FormState>();

  final payload = PatientWeightPayload();

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
              labelText: localisations.form_weight_title,
            ),
            initialValue: payload.weight,
            min: 1,
            onValidChanged: (value) {
              payload.weight = value;
            },
            fieldHintText: localisations.form_weight_validation,
          ),
          const SizedBox(height: 10),
          DropdownMenu<WeightUnit>(
            initialSelection: payload.unit,
            dropdownMenuEntries: WeightUnit.values.map((value) {
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
