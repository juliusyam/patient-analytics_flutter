import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  @override
  Widget build(BuildContext context) {
    final payload = PatientBloodPressurePayload();

    final localisations = AppLocalizations.of(context)!;

    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: localisations.form_systolic_title,
            ),
            initialValue: payload.bloodPressureSystolic.toString(),
            onChanged: (value) {
              final n = int.tryParse(value);
              if (n != null) payload.bloodPressureSystolic = n;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return localisations.form_systolic_validation;
              }
              final n = int.tryParse(value);
              if (n == null) {
                return localisations.form_numeric_validation;
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: localisations.form_diastolic_title,
            ),
            initialValue: payload.bloodPressureDiastolic.toString(),
            onChanged: (value) {
              final n = int.tryParse(value);
              if (n != null) payload.bloodPressureDiastolic = n;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return localisations.form_diastolic_validation;
              }
              final n = int.tryParse(value);
              if (n == null) {
                return localisations.form_numeric_validation;
              }
              return null;
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
