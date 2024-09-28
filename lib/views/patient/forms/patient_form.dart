import 'package:flutter/material.dart';
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

    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'First Name',
              ),
              initialValue: patientPayload.firstName,
              onChanged: (value) {
                patientPayload.firstName = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter first name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Last Name',
              ),
              initialValue: patientPayload.lastName,
              onChanged: (value) {
                patientPayload.lastName = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter last name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              initialValue: patientPayload.email,
              onChanged: (value) {
                patientPayload.email = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                } else if (!value.isValidEmail()) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Gender',
              ),
              initialValue: patientPayload.gender,
              onChanged: (value) {
                patientPayload.gender = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter gender';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
              ),
              initialValue: patientPayload.address,
              onChanged: (value) {
                patientPayload.address = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter address';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            InputDatePickerFormField(
              fieldLabelText: 'Date of Birth',
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
                (widget.patient != null) ? 'Update Patient' : 'Create Patient',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
