import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [CervicalMucusAppearance] to
/// [CervicalMucusAppearanceDto].
///
/// **iOS HealthKit Limitation**: Values `unusual` and `unknown` are included
/// in the DTO but require custom metadata handling in the Swift mapper.
@sinceV2_1_0
@internal
extension CervicalMucusAppearanceToDto on CervicalMucusAppearance {
  /// Converts this [CervicalMucusAppearance] to
  /// [CervicalMucusAppearanceDto].
  CervicalMucusAppearanceDto toDto() {
    switch (this) {
      case CervicalMucusAppearance.unknown:
        return CervicalMucusAppearanceDto.unknown;
      case CervicalMucusAppearance.dry:
        return CervicalMucusAppearanceDto.dry;
      case CervicalMucusAppearance.sticky:
        return CervicalMucusAppearanceDto.sticky;
      case CervicalMucusAppearance.creamy:
        return CervicalMucusAppearanceDto.creamy;
      case CervicalMucusAppearance.watery:
        return CervicalMucusAppearanceDto.watery;
      case CervicalMucusAppearance.eggWhite:
        return CervicalMucusAppearanceDto.eggWhite;
      case CervicalMucusAppearance.unusual:
        return CervicalMucusAppearanceDto.unusual;
    }
  }
}

/// Extension to convert [CervicalMucusAppearanceDto] to
/// [CervicalMucusAppearance].
@sinceV2_1_0
@internal
extension CervicalMucusAppearanceDtoToDomain on CervicalMucusAppearanceDto {
  /// Converts this [CervicalMucusAppearanceDto] to
  /// [CervicalMucusAppearance].
  CervicalMucusAppearance toDomain() {
    switch (this) {
      case CervicalMucusAppearanceDto.unknown:
        return CervicalMucusAppearance.unknown;
      case CervicalMucusAppearanceDto.dry:
        return CervicalMucusAppearance.dry;
      case CervicalMucusAppearanceDto.sticky:
        return CervicalMucusAppearance.sticky;
      case CervicalMucusAppearanceDto.creamy:
        return CervicalMucusAppearance.creamy;
      case CervicalMucusAppearanceDto.watery:
        return CervicalMucusAppearance.watery;
      case CervicalMucusAppearanceDto.eggWhite:
        return CervicalMucusAppearance.eggWhite;
      case CervicalMucusAppearanceDto.unusual:
        return CervicalMucusAppearance.unusual;
    }
  }
}
