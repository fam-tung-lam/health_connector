import 'package:health_connector/health_connector_internal.dart';

/// Toolbox labels for user characteristics.
extension UserCharacteristicTypeUI on UserCharacteristicType<Object> {
  String get displayName => switch (this) {
    BirthDateCharacteristicType() => 'Birth date',
    BiologicalSexCharacteristicType() => 'Biological sex',
  };
}
