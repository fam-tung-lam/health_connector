import 'package:health_connector_core/health_connector_core.dart'
    show RecordingMethod, DeviceType, Device, DataOrigin, Metadata, sinceV1_0_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show RecordingMethodDto, DeviceTypeDto, MetadataDto;
import 'package:meta/meta.dart' show internal;

/// Converts [RecordingMethod] to [RecordingMethodDto].
@sinceV1_0_0
@internal
extension RecordingMethodDtoMapper on RecordingMethod {
  RecordingMethodDto toDto() {
    switch (this) {
      case RecordingMethod.unknown:
        return RecordingMethodDto.unknown;
      case RecordingMethod.manualEntry:
        return RecordingMethodDto.manualEntry;
      case RecordingMethod.automaticallyRecorded:
        return RecordingMethodDto.automaticallyRecorded;
      case RecordingMethod.activelyRecorded:
        return RecordingMethodDto.activelyRecorded;
    }
  }
}

/// Converts [RecordingMethodDto] to [RecordingMethod].
@sinceV1_0_0
@internal
extension RecordingMethodDtoToDomain on RecordingMethodDto {
  RecordingMethod toDomain() {
    switch (this) {
      case RecordingMethodDto.unknown:
        return RecordingMethod.unknown;
      case RecordingMethodDto.manualEntry:
        return RecordingMethod.manualEntry;
      case RecordingMethodDto.automaticallyRecorded:
        return RecordingMethod.automaticallyRecorded;
      case RecordingMethodDto.activelyRecorded:
        return RecordingMethod.activelyRecorded;
    }
  }
}

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

/// Converts [Metadata] to [MetadataDto].
@sinceV1_0_0
@internal
extension MetadataDtoMapper on Metadata {
  MetadataDto toDto() {
    return MetadataDto(
      dataOrigin: dataOrigin.packageName,
      recordingMethod: recordingMethod.toDto(),
      lastModifiedTime: lastModifiedTime?.millisecondsSinceEpoch,
      clientRecordId: clientRecordId,
      clientRecordVersion: clientRecordVersion,
      deviceType: device?.type.toDto(),
      deviceManufacturer: device?.manufacturer,
      deviceModel: device?.model,
    );
  }
}

/// Converts [MetadataDto] to [Metadata].
@sinceV1_0_0
@internal
extension MetadataDtoToDomain on MetadataDto {
  Metadata toDomain() {
    return Metadata(
      dataOrigin: DataOrigin(dataOrigin),
      recordingMethod: recordingMethod.toDomain(),
      lastModifiedTime: lastModifiedTime != null
          ? DateTime.fromMillisecondsSinceEpoch(lastModifiedTime!)
          : null,
      clientRecordId: clientRecordId,
      clientRecordVersion: clientRecordVersion,
      device:
          (deviceType != null ||
              deviceManufacturer != null ||
              deviceModel != null)
          ? Device(
              type: deviceType?.toDomain() ?? DeviceType.unknown,
              manufacturer: deviceManufacturer,
              model: deviceModel,
            )
          : null,
    );
  }
}
