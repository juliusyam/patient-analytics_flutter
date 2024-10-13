import 'dart:convert';

import 'package:patient_analytics_flutter/extensions/string.dart';
import 'package:patient_analytics_flutter/models/enums/unit.dart';

class PatientWeightPayload {
  double weight = 0.0;
  WeightUnit unit = WeightUnit.Kg;

  String toJson() => jsonEncode({
    'weight': weight,
    'unit': unit.toShortString(),
  });
}
