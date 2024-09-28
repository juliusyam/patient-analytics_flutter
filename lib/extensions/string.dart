import '../models/enums/role.dart';

extension EnumEx on String {
  Role toEnum() => Role.values.firstWhere((r) => r.name == this);
}

extension ParseToString on Role {
  String toShortString() => toString().split('.').last;
}
