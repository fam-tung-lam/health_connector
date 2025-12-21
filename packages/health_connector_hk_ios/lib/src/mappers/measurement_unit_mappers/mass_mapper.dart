import 'package:health_connector_core/health_connector_core.dart'
    show Mass, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show MassDto, MassUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Mass] to [MassDto].
@sinceV1_0_0
@internal
extension MassToDto on Mass {
  MassDto toDto() {
    // Uses kilograms as the transfer unit for consistency.
    return MassDto(value: inKilograms, unit: MassUnitDto.kilograms);
  }
}

/// Converts [MassDto] to [Mass].
@sinceV1_0_0
@internal
extension MassDtoToDomain on MassDto {
  Mass toDomain() {
    switch (unit) {
      case MassUnitDto.kilograms:
        return Mass.kilograms(value);
      case MassUnitDto.grams:
        return Mass.grams(value);
      case MassUnitDto.pounds:
        return Mass.pounds(value);
      case MassUnitDto.ounces:
        return Mass.ounces(value);
    }
  }
}
