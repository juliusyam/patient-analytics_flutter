import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:patient_analytics_flutter/extensions/text.dart';

class PatientMetricsTableContainer extends StatelessWidget {
  const PatientMetricsTableContainer({
    super.key,
    required this.title,
    required this.table,
    required this.onPressed,
  });

  final String title;
  final Widget table;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final localisations = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 2.0, color: Colors.cyan.shade100),
        color: Colors.cyan.shade50,
        boxShadow: const [
          BoxShadow(
            spreadRadius: 0.05,
            blurRadius: 7.0,
            color: Colors.white70,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(title, style: context.title.secondary),
          const SizedBox(height: 10),
          table,
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(localisations.button_view_more),
          ),
        ],
      ),
    );
  }
}
