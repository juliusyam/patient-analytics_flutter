import 'package:flutter/material.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, user, _) => Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('Login'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Login Page'),
                    Text(
                      'This is the login page',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          user.updateUser('Token exists now');
                        },
                        child: const Text('Login')),
                  ],
                ),
              ),
            ));
  }
}
