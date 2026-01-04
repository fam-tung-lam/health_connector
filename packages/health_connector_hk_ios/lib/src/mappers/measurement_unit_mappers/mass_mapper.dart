import 'package:health_connector_core/health_connector_core_internal.dart'
    show Mass, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show MassDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Mass] to [MassDto].
@sinceV1_0_0
@internal
/// Converts [Mass] to [MassDto].
@sinceV1_0_0
@internal
extension MassToDto on Mass {
  MassDto toDto() {
    // Uses kilograms as the transfer unit for consistency.
    return MassDto(kilograms: inKilograms);
  }
}

/// Converts [MassDto] to [Mass].
@sinceV1_0_0
@internal
extension MassDtoToDomain on MassDto {
  Mass toDomain() {
    return Mass.kilograms(kilograms);
  }
}
