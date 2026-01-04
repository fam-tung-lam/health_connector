import 'package:health_connector_core/health_connector_core_internal.dart'
    show Energy, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show EnergyDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Energy] to [EnergyDto].
@sinceV1_0_0
@internal
/// Converts [Energy] to [EnergyDto].
@sinceV1_0_0
@internal
extension EnergyToDto on Energy {
  EnergyDto toDto() {
    // Uses kilocalories as the transfer unit for consistency.
    return EnergyDto(kilocalories: inKilocalories);
  }
}

/// Converts [EnergyDto] to [Energy].
@sinceV1_0_0
@internal
extension EnergyDtoToDomain on EnergyDto {
  Energy toDomain() {
    return Energy.kilocalories(kilocalories);
  }
}
