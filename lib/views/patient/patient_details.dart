import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/services/api_service.dart';
import 'package:patient_analytics_flutter/views/patient/patient_fetch_container.dart';
import 'package:patient_analytics_flutter/views/patient/patient_hero.dart';
import 'package:patient_analytics_flutter/views/patient/tables/patient_blood_pressures_table.dart';

class PatientDetailsPage extends StatefulWidget {
  const PatientDetailsPage({super.key, required this.id});

  final String id;

  @override
  PatientDetailsState createState() => PatientDetailsState();
}

class PatientDetailsState extends State<PatientDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final patientProvider = Modular.get<PatientDetailsProvider>();

      final ApiService apiService = Get.put(ApiService());

      final result = await apiService.getPatientById(int.parse(widget.id));

      result.when((data) {
        setState(() {
          patientProvider.updatePatientDetails(data.extractPatient());
          patientProvider.populateMetrics(data.bloodPressures);
        });
      }, (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final patientDetailsProvider = context.watch<PatientDetailsProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
            '${patientDetailsProvider.patientOrNull?.firstName} ${patientDetailsProvider.patientOrNull?.lastName}'),
      ),
      body: PatientFetchContainer(
        provider: patientDetailsProvider,
        child: (patient) {
          return Column(
            children: <Widget>[
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(10.0),
                color: Colors.cyan.shade50,
                child: PatientHero(patient: patient),
              ),
              Text(
                  'Blood Pressures length: ${patientDetailsProvider.bloodPressures.length}'),
              Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 2.0, color: Colors.cyan.shade100),
                  color: Colors.cyan.shade50,
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 0.05,
                      blurRadius: 7.0,
                      color: Colors.white70,
                    ),
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Text(
                      'Blood Pressure Records',
                      style: TextStyle(
                        color: Colors.cyan.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    PatientBloodPressuresTable(
                      entries: patientDetailsProvider.bloodPressures,
                      limit: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Modular.to.pushNamed(
                            '/doctor-dashboard/patient/${patient.id}/blood-pressures');
                      },
                      child: const Text('View more'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed(
              '/doctor-dashboard/patient/${patientDetailsProvider.patient.id}/edit');
        },
        shape: const CircleBorder(),
        tooltip: 'Edit Patient',
        child: const Icon(CupertinoIcons.pencil),
      ),
    );
  }
}
