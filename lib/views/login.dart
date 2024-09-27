import 'package:flutter/material.dart';
import 'package:patient_analytics_flutter/models/auth/login_payload.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../services/api_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final ApiService _apiService = Get.put(ApiService(token: null));

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, user, _) {
      return Scaffold(
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
                    _apiService.login(LoginPayload('juliusyam_superadmin', 'GodSaveTheQueen123!'));
                  },
                  child: const Text('Hit Login API')),
              ElevatedButton(
                  onPressed: () {
                    user.updateUser('Token exists now');
                  },
                  child: const Text('Login')),
            ],
          ),
        ),
      );
    });
  }
}
