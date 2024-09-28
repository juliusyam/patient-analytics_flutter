import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:patient_analytics_flutter/providers/user_provider.dart';
import 'package:patient_analytics_flutter/views/dashboard/dashboard.dart';
import 'package:patient_analytics_flutter/views/login/login.dart';
import 'package:provider/provider.dart';

void main() async {
  await GetStorage.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, user, _) {
        if (user.token != null) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
              useMaterial3: true,
            ),
            home: const DashboardPage(),
          );
        } else {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
              useMaterial3: true,
            ),
            home: LoginPage(),
          );
        }
      },
    );
  }
}
