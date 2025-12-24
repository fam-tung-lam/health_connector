import 'package:health_connector_core/health_connector_core_internal.dart'
    show DeviceType, Device, DataOrigin, Metadata, sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/device_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/recording_method_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
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
