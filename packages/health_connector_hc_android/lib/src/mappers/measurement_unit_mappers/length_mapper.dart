import 'package:health_connector_core/health_connector_core.dart' show Length;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show LengthDto, LengthUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Length] to [LengthDto].
@internal
extension LengthToDto on Length {
  LengthDto toDto() {
    // Uses meters as the transfer unit for consistency.
    return LengthDto(value: inMeters, unit: LengthUnitDto.meters);
  }
}

/// Converts [LengthDto] to [Length].
@internal
extension LengthDtoToDomain on LengthDto {
  Length toDomain() {
    switch (unit) {
      case LengthUnitDto.meters:
        return Length.meters(value);
      case LengthUnitDto.kilometers:
        return Length.kilometers(value);
      case LengthUnitDto.miles:
        return Length.miles(value);
      case LengthUnitDto.feet:
        return Length.feet(value);
      case LengthUnitDto.inches:
        return Length.inches(value);
    }
  }
}
