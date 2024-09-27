import 'package:flutter/material.dart';
import 'package:patient_analytics_flutter/models/auth/login_payload.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';
import 'package:patient_analytics_flutter/views/login/login_form.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../services/api_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final ApiService _apiService = Get.put(ApiService(token: null));

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, user, _) {

      Future<void> onSubmit(LoginPayload loginPayload) async {
        final result = await _apiService.login(loginPayload);

        result.when((data) {
          user.updateUser(data.token);
        }, (error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
        });
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Login'),
        ),
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(20.0),
          child: Wrap(
            children: [
              LoginForm(onSubmit: (payload) async => await onSubmit(payload))
            ],
          )
        ),
      );
    });
  }
}
