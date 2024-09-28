import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';

class DoctorDashboardPage extends StatelessWidget {
  DoctorDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Dashboard'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  child: const Text('Logout')),
            ],
          ),
        ),
      );
    });
  }
}
