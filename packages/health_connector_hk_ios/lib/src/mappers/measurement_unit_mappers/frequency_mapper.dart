import 'package:health_connector_core/health_connector_core_internal.dart'
    show Frequency, sinceV3_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show FrequencyDto;
import 'package:meta/meta.dart' show internal;

/// Converts a [Frequency] domain model to a [FrequencyDto].
@sinceV3_0_0
@internal
extension FrequencyToDto on Frequency {
  /// Converts this frequency to a DTO.
  FrequencyDto toDto() => FrequencyDto(perMinute: inPerMinute);
}

/// Converts a [FrequencyDto] to a [Frequency] domain model.
@sinceV3_0_0
@internal
extension FrequencyDtoToDomain on FrequencyDto {
  /// Converts this DTO to a domain frequency.
  Frequency toDomain() => Frequency.perMinute(perMinute);
}
