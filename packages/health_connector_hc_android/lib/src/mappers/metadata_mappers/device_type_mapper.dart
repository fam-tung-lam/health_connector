import 'package:health_connector_core/health_connector_core_internal.dart'
    show DeviceType, sinceV1_0_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show DeviceTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DeviceType] to [DeviceTypeDto].
@sinceV1_0_0
@internal
extension DeviceTypeDtoMapper on DeviceType {
  DeviceTypeDto toDto() {
    switch (this) {
      case DeviceType.unknown:
        return DeviceTypeDto.unknown;
      case DeviceType.watch:
        return DeviceTypeDto.watch;
      case DeviceType.phone:
        return DeviceTypeDto.phone;
      case DeviceType.scale:
        return DeviceTypeDto.scale;
      case DeviceType.ring:
        return DeviceTypeDto.ring;
      case DeviceType.fitnessBand:
        return DeviceTypeDto.fitnessBand;
      case DeviceType.chestStrap:
        return DeviceTypeDto.chestStrap;
      case DeviceType.headMounted:
        return DeviceTypeDto.headMounted;
      case DeviceType.smartDisplay:
        return DeviceTypeDto.smartDisplay;
    }
  }
}

/// Converts [DeviceTypeDto] to [DeviceType].
@sinceV1_0_0
@internal
extension DeviceTypeDtoToDomain on DeviceTypeDto {
  DeviceType toDomain() {
    switch (this) {
      case DeviceTypeDto.unknown:
        return DeviceType.unknown;
      case DeviceTypeDto.watch:
        return DeviceType.watch;
      case DeviceTypeDto.phone:
        return DeviceType.phone;
      case DeviceTypeDto.scale:
        return DeviceType.scale;
      case DeviceTypeDto.ring:
        return DeviceType.ring;
      case DeviceTypeDto.fitnessBand:
        return DeviceType.fitnessBand;
      case DeviceTypeDto.chestStrap:
        return DeviceType.chestStrap;
      case DeviceTypeDto.headMounted:
        return DeviceType.headMounted;
      case DeviceTypeDto.smartDisplay:
        return DeviceType.smartDisplay;
    }
  }
}
