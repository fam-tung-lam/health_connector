import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [CervicalMucusSensation] to
/// [CervicalMucusSensationDto].
///
/// **iOS HealthKit Limitation**: All sensation values require custom metadata
/// handling in the Swift mapper.
@internal
extension CervicalMucusSensationToDto on CervicalMucusSensation {
  /// Converts this [CervicalMucusSensation] to
  /// [CervicalMucusSensationDto].
  CervicalMucusSensationDto toDto() {
    switch (this) {
      case CervicalMucusSensation.unknown:
        return CervicalMucusSensationDto.unknown;
      case CervicalMucusSensation.light:
        return CervicalMucusSensationDto.light;
      case CervicalMucusSensation.medium:
        return CervicalMucusSensationDto.medium;
      case CervicalMucusSensation.heavy:
        return CervicalMucusSensationDto.heavy;
    }
  }
}

/// Extension to convert [CervicalMucusSensationDto] to
/// [CervicalMucusSensation].
@internal
extension CervicalMucusSensationDtoToDomain on CervicalMucusSensationDto {
  /// Converts this [CervicalMucusSensationDto] to
  /// [CervicalMucusSensation].
  CervicalMucusSensation toDomain() {
    switch (this) {
      case CervicalMucusSensationDto.unknown:
        return CervicalMucusSensation.unknown;
      case CervicalMucusSensationDto.light:
        return CervicalMucusSensation.light;
      case CervicalMucusSensationDto.medium:
        return CervicalMucusSensation.medium;
      case CervicalMucusSensationDto.heavy:
        return CervicalMucusSensation.heavy;
    }
  }
}
