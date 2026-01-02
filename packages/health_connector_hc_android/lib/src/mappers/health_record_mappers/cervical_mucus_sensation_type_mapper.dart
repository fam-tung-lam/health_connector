import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [CervicalMucusSensationType] to
/// [CervicalMucusSensationTypeDto].
@sinceV2_1_0
@internal
extension CervicalMucusSensationTypeToDto on CervicalMucusSensationType {
  /// Converts this [CervicalMucusSensationType] to
  /// [CervicalMucusSensationTypeDto].
  CervicalMucusSensationTypeDto toDto() {
    switch (this) {
      case CervicalMucusSensationType.unknown:
        return CervicalMucusSensationTypeDto.unknown;
      case CervicalMucusSensationType.light:
        return CervicalMucusSensationTypeDto.light;
      case CervicalMucusSensationType.medium:
        return CervicalMucusSensationTypeDto.medium;
      case CervicalMucusSensationType.heavy:
        return CervicalMucusSensationTypeDto.heavy;
    }
  }
}

/// Extension to convert [CervicalMucusSensationTypeDto] to
/// [CervicalMucusSensationType].
@sinceV2_1_0
@internal
extension CervicalMucusSensationTypeDtoToDomain
    on CervicalMucusSensationTypeDto {
  /// Converts this [CervicalMucusSensationTypeDto] to
  /// [CervicalMucusSensationType].
  CervicalMucusSensationType toDomain() {
    switch (this) {
      case CervicalMucusSensationTypeDto.unknown:
        return CervicalMucusSensationType.unknown;
      case CervicalMucusSensationTypeDto.light:
        return CervicalMucusSensationType.light;
      case CervicalMucusSensationTypeDto.medium:
        return CervicalMucusSensationType.medium;
      case CervicalMucusSensationTypeDto.heavy:
        return CervicalMucusSensationType.heavy;
    }
  }
}
