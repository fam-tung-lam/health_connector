import 'package:health_connector_core/health_connector_core.dart' show Mass;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show MassDto, MassUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Mass] to [MassDto].
@internal
extension MassToDto on Mass {
  MassDto toDto() {
    // Uses kilograms as the transfer unit for consistency.
    return MassDto(value: inKilograms, unit: MassUnitDto.kilograms);
  }
}

/// Converts [MassDto] to [Mass].
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
