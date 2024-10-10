import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:patient_analytics_flutter/extensions/text.dart';
import 'package:patient_analytics_flutter/models/auth/login_payload.dart';

class LoginForm extends StatefulWidget {
  final ValueChanged<LoginPayload> onSubmit;
  const LoginForm({super.key, required this.onSubmit});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  final loginPayload = LoginPayload();

  @override
  Widget build(BuildContext context) {

    final localisations = AppLocalizations.of(context)!;

    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 2.0, color: Colors.cyan.shade300),
          color: Colors.cyan.shade50,
          boxShadow: const [
            BoxShadow(spreadRadius: 0.05, blurRadius: 7.0, color: Colors.white70)
          ],
        ),
        child: Column(
          children: <Widget>[
            Text(localisations.title_login, style: context.title.secondary),
            const SizedBox(height: 10),
            TextFormField(
              style: context.body.regular,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: localisations.form_username_title,
              ),
              onChanged: (value) {
                loginPayload.username = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localisations.form_username_validation;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: context.body.regular,
              obscureText: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: localisations.form_password_title,
              ),
              onChanged: (value) {
                loginPayload.password = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localisations.form_password_validation;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    widget.onSubmit(loginPayload);
                  }
                },
                child: Text(localisations.button_login)
            ),
          ],
        ),
      ),
    );
  }
}
