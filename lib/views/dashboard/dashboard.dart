import 'package:flutter/material.dart';
import 'package:patient_analytics_flutter/models/enums/role.dart';
import 'package:patient_analytics_flutter/providers/doctor_dashboard_provider.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';
import 'package:patient_analytics_flutter/views/dashboard/admin_dashboard.dart';
import 'package:patient_analytics_flutter/views/dashboard/doctor_dashboard.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      switch (userProvider.user?.role) {
        case Role.SuperAdmin:
        case Role.Admin:
          return const AdminDashboardPage();
        case Role.Doctor:
          return ChangeNotifierProvider(
            create: (context) => DoctorDashboardProvider(),
            child: const DoctorDashboardPage(),
          );
        case null:
          return Container(
            color: Colors.cyan.shade50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(
                  'Fetching user details...',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          );
      }
    });
  }
}
