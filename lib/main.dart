import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_storage/get_storage.dart';
import 'package:patient_analytics_flutter/modules/app_module.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  await GetStorage.init();

  setPathUrlStrategy();

  runApp(ModularApp(module: AppModule(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  final supportedLocales = [
    const Locale('en'),
    const Locale('es'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Patient Analytics - Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      routerConfig: Modular.routerConfig,
    );
  }
}
