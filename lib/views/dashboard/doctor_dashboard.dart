import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_analytics_flutter/providers/doctor_dashboard_provider.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';
import 'package:patient_analytics_flutter/services/api_service.dart';
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
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final doctorDashboardProvider =
          Provider.of<DoctorDashboardProvider>(context, listen: false);

      print("Token: ${userProvider.token}");

      final ApiService apiService =
          Get.put(ApiService(token: userProvider.token));

      final result = await apiService.getPatients();

      result.when((data) {
        print(data);
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
        Provider.of<DoctorDashboardProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Doctor Dashboard'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('Doctor Dashboard'),
            Text('Username: ${userProvider.user?.username}'),
            Text('FirstName: ${userProvider.user?.firstName}'),
            Text('LastName: ${userProvider.user?.lastName}'),
            Text('Date of Birth: ${userProvider.user?.dateOfBirth}'),
            Text('Role: ${userProvider.user?.role}'),
            Text('Patients Length: ${doctorDashboardProvider.patients.length}'),
            ElevatedButton(
              onPressed: () {
                userProvider.removeUser();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
