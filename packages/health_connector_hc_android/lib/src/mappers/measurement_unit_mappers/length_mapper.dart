import 'package:health_connector_core/health_connector_core_internal.dart'
    show Length;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show LengthDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Length] to [LengthDto].
@internal
extension LengthToDto on Length {
  LengthDto toDto() {
    // Uses meters as the transfer unit for consistency.
    return LengthDto(meters: inMeters);
  }
}

/// Converts [LengthDto] to [Length].
@internal
extension LengthDtoToDomain on LengthDto {
  Length toDomain() {
    return Length.meters(meters);
  }
}
