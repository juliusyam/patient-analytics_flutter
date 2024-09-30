import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntegerFormField extends StatelessWidget {
  const IntegerFormField({
    super.key,
    this.decoration,
    this.initialValue,
    required this.onValidChanged,
    this.fieldHintText,
    this.min,
    this.max,
  });

  final int? initialValue;
  final InputDecoration? decoration;
  final ValueChanged<int> onValidChanged;
  final String? fieldHintText;
  final double? min;
  final double? max;

  @override
  Widget build(BuildContext context) {
    final localisations = AppLocalizations.of(context)!;

    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]*')),
      ],
      decoration: decoration,
      initialValue: initialValue.toString(),
      onChanged: (value) {
        final n = int.tryParse(value);
        if (n != null) onValidChanged(n);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return fieldHintText ?? localisations.form_numeric_validation;
        }
        final n = int.tryParse(value);
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
