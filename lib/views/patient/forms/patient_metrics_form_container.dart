import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientMetricsFormContainer extends StatelessWidget {
  const PatientMetricsFormContainer({super.key, required this.form});

  final Widget form;

  @override
  Widget build(BuildContext context) {
    final localisations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 20.0,
          left: 20.0,
          right: 20.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
        ),
        child: Column(
          children: <Widget>[
            form,
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(localisations.button_close),
            ),
          ],
        ),
      ),
    );
  }
}
