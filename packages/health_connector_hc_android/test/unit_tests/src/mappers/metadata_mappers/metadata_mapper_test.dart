import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'MetadataMapper',
    () {
      const dataOriginName = 'com.example.app';
      const lastModifiedTimeMs = 1678886400000; // 2023-03-15T16:00:00.000Z
      final lastModifiedTime = DateTime.fromMillisecondsSinceEpoch(
        lastModifiedTimeMs,
      );
      const clientRecordId = 'client_record_id_123';
      const clientRecordVersion = 1;
      const deviceManufacturer = 'Google';
      const deviceModel = 'Pixel Watch';

      group(
        'MetadataDtoMapper',
        () {
          test(
            'maps Metadata to MetadataDto with all fields populated',
            () {
              final metadata = Metadata.internal(
                dataOrigin: const DataOrigin(dataOriginName),
                recordingMethod: RecordingMethod.manualEntry,
                lastModifiedTime: lastModifiedTime,
                clientRecordId: clientRecordId,
                clientRecordVersion: clientRecordVersion,
                device: const Device(
                  type: DeviceType.watch,
                  manufacturer: deviceManufacturer,
                  model: deviceModel,
                ),
              );

              final dto = metadata.toDto();

              expect(dto.dataOrigin, dataOriginName);
              expect(dto.recordingMethod, RecordingMethodDto.manualEntry);
              expect(dto.lastModifiedTime, lastModifiedTimeMs);
              expect(dto.clientRecordId, clientRecordId);
              expect(dto.clientRecordVersion, clientRecordVersion);
              expect(dto.deviceType, DeviceTypeDto.watch);
              expect(dto.deviceManufacturer, deviceManufacturer);
              expect(dto.deviceModel, deviceModel);
            },
          );

          test(
            'maps Metadata to MetadataDto with nullable fields',
            () {
              final metadata = Metadata.internal(
                dataOrigin: DataOrigin(dataOriginName),
                recordingMethod: RecordingMethod.unknown,
                clientRecordVersion: 0,
              );

              final dto = metadata.toDto();

              expect(dto.dataOrigin, dataOriginName);
              expect(dto.recordingMethod, RecordingMethodDto.unknown);
              expect(dto.lastModifiedTime, null);
              expect(dto.clientRecordId, null);
              expect(dto.clientRecordVersion, 0);
              expect(dto.deviceType, DeviceTypeDto.unknown);
              expect(dto.deviceManufacturer, null);
              expect(dto.deviceModel, null);
            },
          );
        },
      );

      group(
        'MetadataDtoToDomain',
        () {
          test(
            'maps MetadataDto to Metadata with all fields populated',
            () {
              final dto = MetadataDto(
                dataOrigin: dataOriginName,
                recordingMethod: RecordingMethodDto.activelyRecorded,
                lastModifiedTime: lastModifiedTimeMs,
                clientRecordId: clientRecordId,
                clientRecordVersion: clientRecordVersion,
                deviceType: DeviceTypeDto.phone,
                deviceManufacturer: deviceManufacturer,
                deviceModel: deviceModel,
              );

              final metadata = dto.toDomain();

              expect(metadata.dataOrigin?.packageName, dataOriginName);
              expect(
                metadata.recordingMethod,
                RecordingMethod.activelyRecorded,
              );
              expect(metadata.lastModifiedTime, lastModifiedTime);
              expect(metadata.clientRecordId, clientRecordId);
              expect(metadata.clientRecordVersion, clientRecordVersion);
              expect(metadata.device!.type, DeviceType.phone);
              expect(metadata.device!.manufacturer, deviceManufacturer);
              expect(metadata.device!.model, deviceModel);
            },
          );

          test(
            'maps MetadataDto to Metadata with nullable fields',
            () {
              final dto = MetadataDto(
                dataOrigin: dataOriginName,
                recordingMethod: RecordingMethodDto.unknown,
                clientRecordVersion: 0,
                deviceType: DeviceTypeDto.unknown,
              );

              final metadata = dto.toDomain();

              expect(metadata.dataOrigin?.packageName, dataOriginName);
              expect(metadata.recordingMethod, RecordingMethod.unknown);
              expect(metadata.lastModifiedTime, null);
              expect(metadata.clientRecordId, null);
              expect(metadata.clientRecordVersion, 0);
              expect(metadata.device!.type, DeviceType.unknown);
              expect(metadata.device!.manufacturer, null);
              expect(metadata.device!.model, null);
            },
          );
        },
      );
    },
  );
}
