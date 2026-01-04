import 'package:health_connector_core/health_connector_core_internal.dart'
    show Energy;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show EnergyDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Energy] to [EnergyDto].
@internal
extension EnergyToDto on Energy {
  EnergyDto toDto() {
    // Uses kilocalories as the transfer unit for consistency.
    return EnergyDto(
      kilocalories: inKilocalories,
    );
  }
}

/// Converts [EnergyDto] to [Energy].
@internal
extension EnergyDtoToDomain on EnergyDto {
  Energy toDomain() {
    return Energy.kilocalories(kilocalories);
  }
}
