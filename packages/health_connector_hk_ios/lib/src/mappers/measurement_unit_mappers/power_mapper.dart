import 'package:health_connector_core/health_connector_core_internal.dart'
    show Power, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show PowerDto, PowerUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Power] to [PowerDto].
@sinceV1_0_0
@internal
extension PowerToDto on Power {
  PowerDto toDto() {
    // Uses watts as the transfer unit for consistency.
    return PowerDto(value: inWatts, unit: PowerUnitDto.watts);
  }
}

/// Converts [PowerDto] to [Power].
@sinceV1_0_0
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
