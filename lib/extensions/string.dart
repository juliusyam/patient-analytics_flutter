import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:patient_analytics_flutter/models/enums/unit.dart';
import 'package:patient_analytics_flutter/models/enums/role.dart';

extension EnumEx on String {
  Role toRoleEnum() => Role.values.firstWhere((r) => r.name == this);

  HeightUnit toHeightUnitEnum() =>
      HeightUnit.values.firstWhere((r) => r.name == this);
}

extension ParseToRoleString on Role {
  String toShortString() => toString().split('.').last;
}

extension ParseToHeightUnitString on HeightUnit {
  String toShortString() => toString().split('.').last;

  String toLocalizedString(AppLocalizations localisations) {
    return switch (this) {
      HeightUnit.Cm => localisations.label_cm,
      HeightUnit.In => localisations.label_in,
    };
  }
}

extension ParseToTemperatureUnitString on TemperatureUnit {
  String toShortString() => toString().split('.').last;

  String toLocalizedString(AppLocalizations localisations) {
    return switch (this) {
      TemperatureUnit.Celsius => localisations.label_celsius,
      TemperatureUnit.Fahrenheit => localisations.label_fahrenheit,
    };
  }
}

extension ParseToWeightUnitString on WeightUnit {
  String toShortString() => toString().split('.').last;

  String toLocalizedString(AppLocalizations localisations) {
    return switch (this) {
      WeightUnit.Kg => localisations.label_kg,
      WeightUnit.Lb => localisations.label_lb,
      WeightUnit.St => localisations.label_st,
    };
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
