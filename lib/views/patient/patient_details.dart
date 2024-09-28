import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/services/api_service.dart';
import 'package:patient_analytics_flutter/views/patient/patient_blood_pressures.dart';
import 'package:patient_analytics_flutter/views/patient/patient_hero.dart';
import 'package:patient_analytics_flutter/views/patient/tables/patient_blood_pressures_table.dart';
import 'package:provider/provider.dart';

class PatientDetailsPage extends StatefulWidget {
  const PatientDetailsPage({super.key});

  @override
  PatientDetailsState createState() => PatientDetailsState();
}

class PatientDetailsState extends State<PatientDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final patientProvider =
          Provider.of<PatientDetailsProvider>(context, listen: false);

      final ApiService apiService = Get.put(ApiService());

      final result =
          await apiService.getPatientById(patientProvider.patient.id);

      result.when((data) {
        setState(() {
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
    return Consumer<PatientDetailsProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
              '${provider.patient.firstName} ${provider.patient.lastName}'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(10.0),
              color: Colors.cyan.shade50,
              child: PatientHero(patient: provider.patient),
            ),
            Text("Blood Pressures length: ${provider.bloodPressures.length}"),
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
                  PatientBloodPressuresTable(limit: 5),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                          return ChangeNotifierProvider<PatientDetailsProvider>.value(
                            value: provider,
                            child: PatientBloodPressuresPage(),
                          );
                        }));
                      },
                      child: const Text('View more')
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          tooltip: 'Edit',
          child: const Icon(CupertinoIcons.pencil),
        ),
      );
    });
  }
}
