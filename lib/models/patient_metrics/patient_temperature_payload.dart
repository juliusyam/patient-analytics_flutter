import 'dart:convert';

import 'package:patient_analytics_flutter/extensions/string.dart';
import 'package:patient_analytics_flutter/models/enums/unit.dart';

class PatientTemperaturePayload {
  double temperature = 0.0;
  TemperatureUnit unit = TemperatureUnit.Celsius;

  String toJson() => jsonEncode({
        'temperature': temperature,
        'unit': unit.toShortString(),
      });
}
