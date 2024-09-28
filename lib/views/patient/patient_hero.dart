import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient_analytics_flutter/models/patient.dart';

class PatientHero extends StatelessWidget {
  final Patient patient;
  final VoidCallback? onTap;

  const PatientHero({super.key, required this.patient, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'patient-${patient.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${patient.firstName} ${patient.lastName}',
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Text(patient.email),
              Text(DateFormat('yyyy-MM-dd').format(patient.dateOfBirth))
            ],
          ),
        ),
      ),
    );
  }
}
