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
        case Role.superadmin:
        case Role.admin:
          return const AdminDashboardPage();
        case Role.doctor:
          return ChangeNotifierProvider(
            create: (context) => DoctorDashboardProvider(),
            child: const DoctorDashboardPage(),
          );
        case null:
          throw Exception('Role must be defined');
      }
    });
  }
}
