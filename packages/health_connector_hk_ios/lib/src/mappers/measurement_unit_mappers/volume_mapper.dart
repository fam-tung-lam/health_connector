import 'package:health_connector_core/health_connector_core_internal.dart'
    show Volume, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show VolumeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Volume] to [VolumeDto].
@sinceV1_0_0
@internal
/// Converts [Volume] to [VolumeDto].
@sinceV1_0_0
@internal
extension VolumeToDto on Volume {
  VolumeDto toDto() {
    // Uses liters as the transfer unit for consistency.
    return VolumeDto(liters: inLiters);
  }
}

/// Converts [VolumeDto] to [Volume].
@sinceV1_0_0
@internal
extension VolumeDtoToDomain on VolumeDto {
  Volume toDomain() {
    return Volume.liters(liters);
  }
}
