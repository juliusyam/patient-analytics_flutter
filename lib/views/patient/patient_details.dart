import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/services/api_service.dart';
import 'package:patient_analytics_flutter/views/patient/patient_hero.dart';
import 'package:provider/provider.dart';

class PatientDetailsPage extends StatefulWidget {
  const PatientDetailsPage({super.key});

  @override
  PatientDetailsState createState()=> PatientDetailsState();
}

class PatientDetailsState extends State<PatientDetailsPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final patientProvider = Provider.of<PatientDetailsProvider>(context, listen: false);

      final ApiService apiService = Get.put(ApiService());

      final result = await apiService.getPatientById(patientProvider.patient.id);

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
          title: Text('${provider.patient.firstName} ${provider.patient.lastName}'),
        ),
        body: Column(
            children: <Widget>[
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(10.0),
                color: Colors.cyan.shade50,
                child: PatientHero(patient: provider.patient),
              ),
              Text("Blood Pressures length: ${provider.bloodPressures.length}")
            ],
        ),
      );
    });
  }
}
