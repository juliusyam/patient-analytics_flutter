import 'package:flutter_modular/flutter_modular.dart';
import 'package:patient_analytics_flutter/models/enums/role.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';

class DoctorGuard extends RouteGuard {
  DoctorGuard() : super(redirectTo: '/');

  @override
  bool canActivate(String path, ParallelRoute route) {
    return Modular.get<UserProvider>().user?.role == Role.Doctor;
  }
}
