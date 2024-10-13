import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:patient_analytics_flutter/extensions/text.dart';

class DoubleFormField extends StatelessWidget {
  const DoubleFormField({
    super.key,
    this.decoration,
    this.initialValue,
    required this.onValidChanged,
    this.fieldHintText,
    this.min,
    this.max,
  });

  final double? initialValue;
  final InputDecoration? decoration;
  final ValueChanged<double> onValidChanged;
  final String? fieldHintText;
  final double? min;
  final double? max;

  @override
  Widget build(BuildContext context) {
    final localisations = AppLocalizations.of(context)!;

    return TextFormField(
      style: context.body.regular,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9.]*')),
      ],
      decoration: decoration,
      initialValue: initialValue.toString(),
      onChanged: (value) {
        final n = double.tryParse(value);
        if (n != null) onValidChanged(n);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return fieldHintText ?? localisations.form_numeric_validation;
        }
        final n = double.tryParse(value);
        if (n == null) {
          return localisations.form_numeric_validation;
        }
        if (min != null && n < min!) {
          return localisations.form_numeric_validation_min(min!);
        }
        if (max != null && n > max!) {
          return localisations.form_numeric_validation_max(max!);
        }
        return null;
      },
    );
  }
}
