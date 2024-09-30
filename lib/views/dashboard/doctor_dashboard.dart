import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_analytics_flutter/providers/doctor_dashboard_provider.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';
import 'package:patient_analytics_flutter/services/api_service.dart';
import 'package:patient_analytics_flutter/views/patient/patient_create.dart';
import 'package:patient_analytics_flutter/views/patient/patient_details.dart';
import 'package:patient_analytics_flutter/views/patient/patient_hero.dart';
import 'package:provider/provider.dart';

class DoctorDashboardPage extends StatefulWidget {
  const DoctorDashboardPage({super.key});

  @override
  DoctorDashboardState createState() => DoctorDashboardState();
}

class DoctorDashboardState extends State<DoctorDashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final doctorDashboardProvider =
          Provider.of<DoctorDashboardProvider>(context, listen: false);

      final ApiService apiService = Get.put(ApiService());

      final result = await apiService.getPatients();

      result.when((data) {
        setState(() {
          doctorDashboardProvider.populatePatients(data);
        });
      }, (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final doctorDashboardProvider =
        Provider.of<DoctorDashboardProvider>(context);

    List<Widget> patientWidgets = [];
    for (var patient in doctorDashboardProvider.patients) {
      patientWidgets.add(Container(
        width: double.maxFinite,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 2.0, color: Colors.cyan.shade300),
          color: Colors.cyan.shade50,
          boxShadow: const [
            BoxShadow(
                spreadRadius: 0.05, blurRadius: 7.0, color: Colors.white70)
          ],
        ),
        child: PatientHero(
          patient: patient,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return ChangeNotifierProvider(
                create: (_) => PatientDetailsProvider(patient: patient),
                child: const PatientDetailsPage(),
              );
            }));
          },
        ),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Doctor Dashboard'),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          const Text('Doctor Dashboard'),
          Text('Username: ${userProvider.user?.username}'),
          Text('FirstName: ${userProvider.user?.firstName}'),
          Text('LastName: ${userProvider.user?.lastName}'),
          Text('Date of Birth: ${userProvider.user?.dateOfBirth}'),
          Text('Role: ${userProvider.user?.role}'),
          ElevatedButton(
            onPressed: () {
              userProvider.removeUser();
            },
            child: const Text('Logout'),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              children: patientWidgets,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return ChangeNotifierProvider<DoctorDashboardProvider>.value(
              value: doctorDashboardProvider,
              child: const PatientCreatePage(),
            );
          }));
        },
        shape: const CircleBorder(),
        tooltip: 'Create Patient',
        child: const Icon(CupertinoIcons.plus),
      ),
    );
  }
}
