import 'package:health_connector_core/health_connector_core_internal.dart'
    show Power;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show PowerDto, PowerUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Power] to [PowerDto].
@internal
extension PowerToDto on Power {
  PowerDto toDto() {
    // Uses watts as the transfer unit for consistency.
    return PowerDto(value: inWatts, unit: PowerUnitDto.watts);
  }
}

/// Converts [PowerDto] to [Power].
@internal
extension PowerDtoToDomain on PowerDto {
  Power toDomain() {
    switch (unit) {
      case PowerUnitDto.watts:
        return Power.watts(value);
      case PowerUnitDto.kilowatts:
        return Power.kilowatts(value);
    }
  }
}
