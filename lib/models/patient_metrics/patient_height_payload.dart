import 'dart:convert';

import 'package:patient_analytics_flutter/extensions/string.dart';
import 'package:patient_analytics_flutter/models/enums/unit.dart';

class PatientHeightPayload {
  double height = 0.0;
  HeightUnit unit = HeightUnit.Cm;

  String toJson() => jsonEncode({
        'height': height,
        'unit': unit.toShortString(),
      });
}
