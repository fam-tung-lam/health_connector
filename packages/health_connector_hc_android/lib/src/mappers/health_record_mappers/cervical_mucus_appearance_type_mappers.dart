import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [CervicalMucusAppearanceType] to
/// [CervicalMucusAppearanceTypeDto].
@sinceV2_1_0
@internal
extension CervicalMucusAppearanceTypeToDto on CervicalMucusAppearanceType {
  /// Converts this [CervicalMucusAppearanceType] to
  /// [CervicalMucusAppearanceTypeDto].
  CervicalMucusAppearanceTypeDto toDto() {
    switch (this) {
      case CervicalMucusAppearanceType.unknown:
        return CervicalMucusAppearanceTypeDto.unknown;
      case CervicalMucusAppearanceType.dry:
        return CervicalMucusAppearanceTypeDto.dry;
      case CervicalMucusAppearanceType.sticky:
        return CervicalMucusAppearanceTypeDto.sticky;
      case CervicalMucusAppearanceType.creamy:
        return CervicalMucusAppearanceTypeDto.creamy;
      case CervicalMucusAppearanceType.watery:
        return CervicalMucusAppearanceTypeDto.watery;
      case CervicalMucusAppearanceType.eggWhite:
        return CervicalMucusAppearanceTypeDto.eggWhite;
      case CervicalMucusAppearanceType.unusual:
        return CervicalMucusAppearanceTypeDto.unusual;
    }
  }
}

/// Extension to convert [CervicalMucusAppearanceTypeDto] to
/// [CervicalMucusAppearanceType].
@sinceV2_1_0
@internal
extension CervicalMucusAppearanceTypeDtoToDomain
    on CervicalMucusAppearanceTypeDto {
  /// Converts this [CervicalMucusAppearanceTypeDto] to
  /// [CervicalMucusAppearanceType].
  CervicalMucusAppearanceType toDomain() {
    switch (this) {
      case CervicalMucusAppearanceTypeDto.unknown:
        return CervicalMucusAppearanceType.unknown;
      case CervicalMucusAppearanceTypeDto.dry:
        return CervicalMucusAppearanceType.dry;
      case CervicalMucusAppearanceTypeDto.sticky:
        return CervicalMucusAppearanceType.sticky;
      case CervicalMucusAppearanceTypeDto.creamy:
        return CervicalMucusAppearanceType.creamy;
      case CervicalMucusAppearanceTypeDto.watery:
        return CervicalMucusAppearanceType.watery;
      case CervicalMucusAppearanceTypeDto.eggWhite:
        return CervicalMucusAppearanceType.eggWhite;
      case CervicalMucusAppearanceTypeDto.unusual:
        return CervicalMucusAppearanceType.unusual;
    }
  }
}
