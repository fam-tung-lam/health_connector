import 'package:health_connector_core/health_connector_core_internal.dart'
    show Velocity, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show VelocityDto, VelocityUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Velocity] to [VelocityDto].
@sinceV1_0_0
@internal
extension VelocityToDto on Velocity {
  VelocityDto toDto() {
    // Uses meters per second as the transfer unit for consistency.
    return VelocityDto(
      value: inMetersPerSecond,
      unit: VelocityUnitDto.metersPerSecond,
    );
  }
}

/// Converts [VelocityDto] to [Velocity].
@sinceV1_0_0
@internal
extension VelocityDtoToDomain on VelocityDto {
  Velocity toDomain() {
    switch (unit) {
      case VelocityUnitDto.metersPerSecond:
        return Velocity.metersPerSecond(value);
      case VelocityUnitDto.kilometersPerHour:
        return Velocity.kilometersPerHour(value);
      case VelocityUnitDto.milesPerHour:
        return Velocity.milesPerHour(value);
    }
  }
}
