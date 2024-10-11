import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_analytics_flutter/models/patient.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/services/api_service.dart';

class PatientScaffold extends StatefulWidget {
  const PatientScaffold({
    super.key,
    required this.id,
    this.initialPatient,
    required this.provider,
    required this.appBar,
    required this.body,
    this.floatingActionButton,
  });

  final String id;
  final Patient? initialPatient;
  final PatientDetailsProvider provider;
  final PreferredSizeWidget Function(Patient patient) appBar;
  final Widget Function(Patient patient) body;
  final Widget Function(Patient patient)? floatingActionButton;

  @override
  State<PatientScaffold> createState() => _PatientScaffoldState();
}

class _PatientScaffoldState extends State<PatientScaffold> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final ApiService apiService = Get.put(ApiService());

      // patientOrNull excludes initialPatient provided by Modular navigation
      if (widget.provider.patientOrNull == null) {
        final result = await apiService.getPatientById(int.parse(widget.id));

        result.when((data) {
          setState(() {
            widget.provider.updatePatientDetails(data.extractPatient());
            widget.provider.populateMetrics(data.bloodPressures);
          });
        }, (error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Patient? currentPatientState =
        widget.provider.patientOrNull ?? widget.initialPatient;

    if (currentPatientState == null) {
      return Container(
        color: Colors.cyan.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              'Fetching patient...',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: widget.appBar(currentPatientState),
      body: widget.body(currentPatientState),
      floatingActionButton: (widget.floatingActionButton != null)
          ? widget.floatingActionButton!(currentPatientState)
          : null,
    );
  }
}
