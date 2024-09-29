import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:patient_analytics_flutter/extensions/string.dart';
import 'package:patient_analytics_flutter/models/patient.dart';
import 'package:patient_analytics_flutter/models/patient_payload.dart';

class PatientForm extends StatefulWidget {
  final Patient? patient;
  final ValueChanged<PatientPayload> onSubmit;

  const PatientForm({super.key, this.patient, required this.onSubmit});

  @override
  State<StatefulWidget> createState() => PatientFormState();
}

class PatientFormState extends State<PatientForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final patientPayload = PatientPayload(patient: widget.patient);

    final localisations = AppLocalizations.of(context)!;

    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: localisations.form_firstName_title,
              ),
              initialValue: patientPayload.firstName,
              onChanged: (value) {
                patientPayload.firstName = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localisations.form_firstName_validation;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: localisations.form_lastName_title,
              ),
              initialValue: patientPayload.lastName,
              onChanged: (value) {
                patientPayload.lastName = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localisations.form_lastName_validation;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: localisations.form_email_title,
              ),
              initialValue: patientPayload.email,
              onChanged: (value) {
                patientPayload.email = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localisations.form_email_validation;
                } else if (!value.isValidEmail()) {
                  return localisations.form_email_validation_format;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: localisations.form_gender_title,
              ),
              initialValue: patientPayload.gender,
              onChanged: (value) {
                patientPayload.gender = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localisations.form_gender_validation;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: localisations.form_address_title,
              ),
              initialValue: patientPayload.address,
              onChanged: (value) {
                patientPayload.address = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localisations.form_address_validation;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            InputDatePickerFormField(
              fieldLabelText: localisations.form_dateOfBirth_title,
              initialDate: patientPayload.dateOfBirth,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  widget.onSubmit(patientPayload);
                }
              },
              child: Text(
                (widget.patient != null)
                    ? localisations.button_patient_update
                    : localisations.button_patient_create,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
