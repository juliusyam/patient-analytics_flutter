import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:patient_analytics_flutter/models/auth/login_payload.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';
import 'package:patient_analytics_flutter/services/api_service.dart';
import 'package:patient_analytics_flutter/views/login/login_form.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final ApiService _apiService = Get.put(ApiService());

  @override
  Widget build(BuildContext context) {

    final localisations = AppLocalizations.of(context)!;

    return Consumer<UserProvider>(builder: (context, userProvider, _) {

      Future<void> onSubmit(LoginPayload loginPayload) async {
        final result = await _apiService.login(loginPayload);

        result.when((data) {
          userProvider.updateUser(data.token, data.refreshToken, data.user);
        }, (error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
        });
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(localisations.title_login),
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
