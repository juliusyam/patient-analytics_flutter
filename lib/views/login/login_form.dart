import 'package:flutter/material.dart';
import 'package:patient_analytics_flutter/models/auth/login_payload.dart';

class LoginForm extends StatefulWidget {
  final ValueChanged<LoginPayload> onSubmit;
  const LoginForm({super.key, required this.onSubmit});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final loginPayload = LoginPayload();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
            const Text('Login'),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              onChanged: (value) {
                loginPayload.username = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter username';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onChanged: (value) {
                loginPayload.password = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmit(loginPayload);
                  }
                },
                child: const Text('Hit Login API')
            ),
          ],
        ),
      ),
    );
  }
}
