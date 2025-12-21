import 'package:health_connector_core/health_connector_core.dart' show Energy;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show EnergyDto, EnergyUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Energy] to [EnergyDto].
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
