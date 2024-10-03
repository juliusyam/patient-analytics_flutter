import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patient_analytics_flutter/models/enums/role.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();

    switch (provider.user?.role) {
      case Role.SuperAdmin:
      case Role.Admin:
        Modular.to.navigate('/admin-dashboard');
      case Role.Doctor:
        Modular.to.navigate('/doctor-dashboard');
      case null:
        break;
    }

    return Container(
      color: Colors.cyan.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            'Redirecting to your dashboard...',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
