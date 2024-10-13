import 'package:flutter_modular/flutter_modular.dart';
import 'package:patient_analytics_flutter/guards/admin_guard.dart';
import 'package:patient_analytics_flutter/guards/auth_guard.dart';
import 'package:patient_analytics_flutter/guards/doctor_guard.dart';
import 'package:patient_analytics_flutter/guards/login_guard.dart';
import 'package:patient_analytics_flutter/providers/doctor_dashboard_provider.dart';
import 'package:patient_analytics_flutter/providers/patient_details_provider.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';
import 'package:patient_analytics_flutter/views/dashboard/admin_dashboard.dart';
import 'package:patient_analytics_flutter/views/dashboard/dashboard.dart';
import 'package:patient_analytics_flutter/views/dashboard/doctor_dashboard.dart';
import 'package:patient_analytics_flutter/views/login/login.dart';
import 'package:patient_analytics_flutter/views/patient/patient_blood_pressures.dart';
import 'package:patient_analytics_flutter/views/patient/patient_create.dart';
import 'package:patient_analytics_flutter/views/patient/patient_details.dart';
import 'package:patient_analytics_flutter/views/patient/patient_edit.dart';
import 'package:patient_analytics_flutter/views/patient/patient_heights.dart';
import 'package:patient_analytics_flutter/views/patient/patient_temperatures.dart';
import 'package:patient_analytics_flutter/views/patient/patient_weights.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addInstance<UserProvider>(UserProvider());
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => LoginPage(), guards: [LoginGuard()]);
    r.child(
      '/dashboard',
      child: (_) => const DashboardPage(),
      guards: [AuthGuard()],
    );
    r.module(
      '/doctor-dashboard',
      module: DoctorDashboardModule(),
      guards: [AuthGuard(), DoctorGuard()],
    );
    r.module(
      '/admin-dashboard',
      module: AdminDashboardModule(),
      guards: [AuthGuard(), AdminGuard()],
    );
  }
}

class DoctorDashboardModule extends Module {
  @override
  void binds(Injector i) {
    i.addInstance<DoctorDashboardProvider>(DoctorDashboardProvider());
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const DoctorDashboardPage(),
      transition: TransitionType.noTransition,
    );
    r.child('/create-patient', child: (_) => const PatientCreatePage());
    r.module('/patient', module: PatientModule());
  }
}

class PatientModule extends Module {
  @override
  void binds(Injector i) {
    i.addInstance<PatientDetailsProvider>(PatientDetailsProvider());
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/:id',
      child: (_) => PatientDetailsPage(
        id: r.args.params['id'],
        initialPatient: r.args.data,
      ),
    );
    r.child(
      '/:id/edit',
      child: (_) => PatientEditPage(id: r.args.params['id']),
    );
    r.child(
      '/:id/blood-pressures',
      child: (_) => PatientBloodPressuresPage(id: r.args.params['id']),
    );
    r.child(
      '/:id/heights',
      child: (_) => PatientHeightsPage(id: r.args.params['id']),
    );
    r.child(
      '/:id/temperatures',
      child: (_) => PatientTemperaturesPage(id: r.args.params['id']),
    );
    r.child(
      '/:id/weights',
      child: (_) => PatientWeightsPage(id: r.args.params['id']),
    );
  }
}

class AdminDashboardModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const AdminDashboardPage());
  }
}
