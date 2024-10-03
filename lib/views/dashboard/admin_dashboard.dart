import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Admin Dashboard'),
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
  }
}
