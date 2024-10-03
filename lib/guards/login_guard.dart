import 'package:flutter_modular/flutter_modular.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';

class LoginGuard extends RouteGuard {
  LoginGuard() : super(redirectTo: '/dashboard');

  @override
  bool canActivate(String path, ParallelRoute route) {
    return Modular.get<UserProvider>().token == null;
  }
}
