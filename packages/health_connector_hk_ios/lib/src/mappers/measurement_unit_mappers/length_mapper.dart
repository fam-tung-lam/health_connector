import 'package:health_connector_core/health_connector_core_internal.dart'
    show Length, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show LengthDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Length] to [LengthDto].
@sinceV1_0_0
@internal
/// Converts [Length] to [LengthDto].
@sinceV1_0_0
@internal
extension LengthToDto on Length {
  LengthDto toDto() {
    // Uses meters as the transfer unit for consistency.
    return LengthDto(meters: inMeters);
  }
}

/// Converts [LengthDto] to [Length].
@sinceV1_0_0
@internal
extension LengthDtoToDomain on LengthDto {
  Length toDomain() {
    return Length.meters(meters);
  }
}
