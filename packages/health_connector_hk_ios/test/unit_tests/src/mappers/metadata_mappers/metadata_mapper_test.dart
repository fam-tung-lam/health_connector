import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  const dataOriginName = 'com.example.healthkit';
  const clientRecordId = 'client_123';
  const clientRecordVersion = 5;

  group(
    'MetadataMapper',
    () {
      group(
        'MetadataDtoMapper',
        () {
          test(
            'maps Metadata to MetadataDto with all fields populated',
            () {
              const metadata = Metadata(
                dataOrigin: DataOrigin(dataOriginName),
                recordingMethod: RecordingMethod.activelyRecorded,
                clientRecordId: clientRecordId,
                clientRecordVersion: clientRecordVersion,
                device: Device(
                  type: DeviceType.watch,
                  name: 'Apple Watch',
                  manufacturer: 'Apple Inc.',
                  model: 'Series 9',
                  hardwareVersion: '1.0',
                  firmwareVersion: '10.2',
                  softwareVersion: 'watchOS 10.2',
                  localIdentifier: 'local-123',
                  udiDeviceIdentifier: 'udi-456',
                ),
              );

              final dto = metadata.toDto();

              expect(dto.dataOrigin, dataOriginName);
              expect(
                dto.recordingMethod,
                RecordingMethodDto.activelyRecorded,
              );
              expect(dto.clientRecordId, clientRecordId);
              expect(dto.clientRecordVersion, clientRecordVersion);
              expect(dto.deviceType, DeviceTypeDto.watch);
              expect(dto.deviceName, 'Apple Watch');
              expect(dto.deviceManufacturer, 'Apple Inc.');
              expect(dto.deviceModel, 'Series 9');
              expect(dto.deviceHardwareVersion, '1.0');
              expect(dto.deviceFirmwareVersion, '10.2');
              expect(dto.deviceSoftwareVersion, 'watchOS 10.2');
              expect(dto.deviceLocalIdentifier, 'local-123');
              expect(dto.deviceUdiDeviceIdentifier, 'udi-456');
            },
          );

          test(
            'maps Metadata to MetadataDto with minimal fields',
            () {
              const metadata = Metadata(
                dataOrigin: DataOrigin(dataOriginName),
                recordingMethod: RecordingMethod.unknown,
                clientRecordVersion: 0,
              );

              final dto = metadata.toDto();

              expect(dto.dataOrigin, dataOriginName);
              expect(dto.recordingMethod, RecordingMethodDto.unknown);
              expect(dto.clientRecordId, null);
              expect(dto.clientRecordVersion, 0);
              expect(dto.deviceType, DeviceTypeDto.unknown);
              expect(dto.deviceName, null);
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
                recordingMethod: RecordingMethodDto.manualEntry,
                clientRecordId: clientRecordId,
                clientRecordVersion: clientRecordVersion,
                deviceType: DeviceTypeDto.phone,
                deviceName: 'iPhone 15',
                deviceManufacturer: 'Apple',
                deviceModel: 'iPhone15,2',
                deviceHardwareVersion: 'A17 Pro',
                deviceFirmwareVersion: '1.0',
                deviceSoftwareVersion: 'iOS 17.2',
                deviceLocalIdentifier: 'local-789',
                deviceUdiDeviceIdentifier: 'udi-101',
              );

              final metadata = dto.toDomain();

              expect(metadata.dataOrigin.packageName, dataOriginName);
              expect(metadata.recordingMethod, RecordingMethod.manualEntry);
              expect(metadata.clientRecordId, clientRecordId);
              expect(metadata.clientRecordVersion, clientRecordVersion);
              expect(metadata.device!.type, DeviceType.phone);
              expect(metadata.device!.name, 'iPhone 15');
              expect(metadata.device!.manufacturer, 'Apple');
              expect(metadata.device!.model, 'iPhone15,2');
              expect(metadata.device!.hardwareVersion, 'A17 Pro');
              expect(metadata.device!.firmwareVersion, '1.0');
              expect(metadata.device!.softwareVersion, 'iOS 17.2');
              expect(metadata.device!.localIdentifier, 'local-789');
              expect(metadata.device!.udiDeviceIdentifier, 'udi-101');
            },
          );

          test(
            'maps MetadataDto to Metadata with minimal fields',
            () {
              final dto = MetadataDto(
                dataOrigin: dataOriginName,
                recordingMethod: RecordingMethodDto.unknown,
                clientRecordVersion: 0,
                deviceType: DeviceTypeDto.unknown,
              );

              final metadata = dto.toDomain();

              expect(metadata.dataOrigin.packageName, dataOriginName);
              expect(metadata.recordingMethod, RecordingMethod.unknown);
              expect(metadata.clientRecordId, null);
              expect(metadata.clientRecordVersion, 0);
              expect(metadata.device!.type, DeviceType.unknown);
              expect(metadata.device!.name, null);
            },
          );
        },
      );
    },
  );
}
