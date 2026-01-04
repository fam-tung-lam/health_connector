import 'package:health_connector_core/health_connector_core_internal.dart'
    show Velocity;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show VelocityDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Velocity] to [VelocityDto].
@internal
extension VelocityToDto on Velocity {
  VelocityDto toDto() {
    // Uses meters per second as the transfer unit for consistency.
    return VelocityDto(
      metersPerSecond: inMetersPerSecond,
    );
  }
}

/// Converts [VelocityDto] to [Velocity].
@internal
extension VelocityDtoToDomain on VelocityDto {
  Velocity toDomain() {
    return Velocity.metersPerSecond(metersPerSecond);
  }
}
