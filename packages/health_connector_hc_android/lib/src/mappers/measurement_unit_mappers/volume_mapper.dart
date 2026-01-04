import 'package:health_connector_core/health_connector_core_internal.dart'
    show Volume;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show VolumeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Volume] to [VolumeDto].
@internal
extension VolumeToDto on Volume {
  VolumeDto toDto() {
    // Uses liters as the transfer unit for consistency.
    return VolumeDto(liters: inLiters);
  }
}

/// Converts [VolumeDto] to [Volume].
@internal
extension VolumeDtoToDomain on VolumeDto {
  Volume toDomain() {
    return Volume.liters(liters);
  }
}
