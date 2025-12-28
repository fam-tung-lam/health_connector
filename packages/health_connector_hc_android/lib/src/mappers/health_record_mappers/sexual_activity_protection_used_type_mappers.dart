import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show SexualActivityProtectionUsedTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SexualActivityProtectionUsedType] to
/// [SexualActivityProtectionUsedTypeDto].
@sinceV2_1_0
@internal
extension SexualActivityProtectionUsedTypeToDto
    on SexualActivityProtectionUsedType {
  SexualActivityProtectionUsedTypeDto toDto() {
    switch (this) {
      case SexualActivityProtectionUsedType.protected:
        return SexualActivityProtectionUsedTypeDto.protected;
      case SexualActivityProtectionUsedType.unprotected:
        return SexualActivityProtectionUsedTypeDto.unprotected;
      case SexualActivityProtectionUsedType.unknown:
        return SexualActivityProtectionUsedTypeDto.unknown;
    }
  }
}

/// Converts [SexualActivityProtectionUsedTypeDto] to
/// [SexualActivityProtectionUsedType].
@sinceV2_1_0
@internal
extension SexualActivityProtectionUsedTypeDtoToDomain
    on SexualActivityProtectionUsedTypeDto {
  SexualActivityProtectionUsedType toDomain() {
    switch (this) {
      case SexualActivityProtectionUsedTypeDto.protected:
        return SexualActivityProtectionUsedType.protected;
      case SexualActivityProtectionUsedTypeDto.unprotected:
        return SexualActivityProtectionUsedType.unprotected;
      case SexualActivityProtectionUsedTypeDto.unknown:
        return SexualActivityProtectionUsedType.unknown;
    }
  }
}
