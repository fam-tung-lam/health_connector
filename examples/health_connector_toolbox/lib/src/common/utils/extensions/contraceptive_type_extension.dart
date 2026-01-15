import 'package:health_connector/health_connector.dart';

/// Extension methods for [ContraceptiveType].
extension ContraceptiveTypeExtension on ContraceptiveType {
  /// Returns a user-friendly display name for the contraceptive type.
  String get displayName {
    return switch (this) {
      ContraceptiveType.unknown => 'Unknown',
      ContraceptiveType.implant => 'Implant',
      ContraceptiveType.injection => 'Injection',
      ContraceptiveType.intrauterineDevice => 'IUD',
      ContraceptiveType.intravaginalRing => 'Intravaginal Ring',
      ContraceptiveType.oral => 'Oral (Pill)',
      ContraceptiveType.patch => 'Patch',
    };
  }
}
