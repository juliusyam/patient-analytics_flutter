import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:patient_analytics_flutter/components/form/double_form_field.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_blood_pressure_payload.dart';

class PatientBloodPressureForm extends StatefulWidget {
  const PatientBloodPressureForm({super.key, required this.onSubmit});

  final ValueChanged<PatientBloodPressurePayload> onSubmit;

  @override
  PatientBloodPressureFormState createState() =>
      PatientBloodPressureFormState();
}

class PatientBloodPressureFormState extends State<PatientBloodPressureForm> {
  final formKey = GlobalKey<FormState>();

  final payload = PatientBloodPressurePayload();

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
              labelText: localisations.form_systolic_title,
            ),
            initialValue: payload.bloodPressureSystolic,
            min: 1,
            onValidChanged: (value) {
              payload.bloodPressureSystolic = value;
            },
            fieldHintText: localisations.form_systolic_validation,
          ),
          const SizedBox(height: 10),
          DoubleFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: localisations.form_diastolic_title,
            ),
            initialValue: payload.bloodPressureDiastolic,
            min: 1,
            onValidChanged: (value) {
              payload.bloodPressureDiastolic = value;
            },
            fieldHintText: localisations.form_diastolic_validation,
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
