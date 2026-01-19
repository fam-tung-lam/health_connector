import 'package:health_connector_core/health_connector_core_internal.dart'
    show SexualActivityProtectionUsed;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SexualActivityProtectionUsedDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SexualActivityProtectionUsed] to
/// [SexualActivityProtectionUsedDto].
@internal
extension SexualActivityProtectionUsedToDto on SexualActivityProtectionUsed {
  SexualActivityProtectionUsedDto toDto() {
    switch (this) {
      case SexualActivityProtectionUsed.protected:
        return SexualActivityProtectionUsedDto.protected;
      case SexualActivityProtectionUsed.unprotected:
        return SexualActivityProtectionUsedDto.unprotected;
      case SexualActivityProtectionUsed.unknown:
        return SexualActivityProtectionUsedDto.unknown;
    }
  }
}

/// Converts [SexualActivityProtectionUsedDto] to
/// [SexualActivityProtectionUsed].
@internal
extension SexualActivityProtectionUsedDtoToDomain
    on SexualActivityProtectionUsedDto {
  SexualActivityProtectionUsed toDomain() {
    switch (this) {
      case SexualActivityProtectionUsedDto.protected:
        return SexualActivityProtectionUsed.protected;
      case SexualActivityProtectionUsedDto.unprotected:
        return SexualActivityProtectionUsed.unprotected;
      case SexualActivityProtectionUsedDto.unknown:
        return SexualActivityProtectionUsed.unknown;
    }
  }
}
