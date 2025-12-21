import 'package:health_connector_core/health_connector_core.dart'
    show Energy, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show EnergyDto, EnergyUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Energy] to [EnergyDto].
@sinceV1_0_0
@internal
extension EnergyToDto on Energy {
  EnergyDto toDto() {
    // Uses kilocalories as the transfer unit for consistency.
    return EnergyDto(
      value: inKilocalories,
      unit: EnergyUnitDto.kilocalories,
    );
  }
}

/// Converts [EnergyDto] to [Energy].
@sinceV1_0_0
@internal
extension EnergyDtoToDomain on EnergyDto {
  Energy toDomain() {
    switch (unit) {
      case EnergyUnitDto.kilocalories:
        return Energy.kilocalories(value);
      case EnergyUnitDto.kilojoules:
        return Energy.kilojoules(value);
      case EnergyUnitDto.calories:
        return Energy.calories(value);
      case EnergyUnitDto.joules:
        return Energy.joules(value);
    }
  }
}
