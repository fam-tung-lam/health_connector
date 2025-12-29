import 'package:health_connector_core/health_connector_core_internal.dart'
    show DeviceType, Device, DataOrigin, Metadata, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/device_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/recording_method_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show MetadataDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Metadata] to [MetadataDto].
@sinceV1_0_0
@internal
extension MetadataDtoMapper on Metadata {
  MetadataDto toDto() {
    return MetadataDto(
      dataOrigin: dataOrigin.packageName,
      recordingMethod: recordingMethod.toDto(),
      deviceType: device?.type.toDto() ?? DeviceType.unknown.toDto(),
      clientRecordId: clientRecordId,
      clientRecordVersion: clientRecordVersion,
      deviceName: device?.name,
      deviceManufacturer: device?.manufacturer,
      deviceModel: device?.model,
      deviceHardwareVersion: device?.hardwareVersion,
      deviceFirmwareVersion: device?.firmwareVersion,
      deviceSoftwareVersion: device?.softwareVersion,
      deviceLocalIdentifier: device?.localIdentifier,
      deviceUdiDeviceIdentifier: device?.udiDeviceIdentifier,
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
      clientRecordId: clientRecordId,
      clientRecordVersion: clientRecordVersion,
      device: Device(
        type: deviceType.toDomain(),
        name: deviceName,
        manufacturer: deviceManufacturer,
        model: deviceModel,
        hardwareVersion: deviceHardwareVersion,
        firmwareVersion: deviceFirmwareVersion,
        softwareVersion: deviceSoftwareVersion,
        localIdentifier: deviceLocalIdentifier,
        udiDeviceIdentifier: deviceUdiDeviceIdentifier,
      ),
    );
  }
}
