import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/cycling_distance_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'CyclingDistanceRecordMapper',
    () {
      group(
        'CyclingDistanceRecordToDto',
        () {
          test(
            'converts CyclingDistanceRecord to DistanceActivityRecordDto',
            () {
              // Given
              final record = CyclingDistanceRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                distance: const Length.meters(5000.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.id, FakeData.fakeId);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(
                dto.endTime,
                FakeData.fakeEndTime.millisecondsSinceEpoch,
              );
              expect(
                dto.startZoneOffsetSeconds,
                FakeData.fakeStartTime.timeZoneOffset.inSeconds,
              );
              expect(
                dto.endZoneOffsetSeconds,
                FakeData.fakeEndTime.timeZoneOffset.inSeconds,
              );
              expect(dto.distance.meters, 5000.0);
              expect(dto.activityType, DistanceActivityTypeDto.cycling);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(
                dto.metadata.recordingMethod,
                RecordingMethodDto.manualEntry,
              );
              expect(dto.metadata.clientRecordVersion, 1);
              expect(dto.metadata.deviceType, DeviceTypeDto.phone);
            },
          );

          test(
            'converts CyclingDistanceRecord with different distance value',
            () {
              // Given
              final record = CyclingDistanceRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 2,
                  device: Device(type: DeviceType.watch),
                ),
                distance: const Length.meters(10000.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.distance.meters, 10000.0);
              expect(dto.activityType, DistanceActivityTypeDto.cycling);
              expect(
                dto.metadata.recordingMethod,
                RecordingMethodDto.activelyRecorded,
              );
              expect(dto.metadata.deviceType, DeviceTypeDto.watch);
            },
          );
        },
      );

      group(
        'CyclingDistanceRecordDtoToDomain',
        () {
          test(
            'converts DistanceActivityRecordDto to CyclingDistanceRecord',
            () {
              // Given
              final dto = DistanceActivityRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                distance: LengthDto(meters: 4500.0),
                activityType: DistanceActivityTypeDto.cycling,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<CyclingDistanceRecord>());
              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(
                record.startZoneOffsetSeconds,
                FakeData.fakeStartTime.timeZoneOffset.inSeconds,
              );
              expect(
                record.endZoneOffsetSeconds,
                FakeData.fakeStartTime.timeZoneOffset.inSeconds,
              );
              expect(record.distance.inMeters, 4500.0);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(
                record.metadata.recordingMethod,
                RecordingMethod.activelyRecorded,
              );
              expect(record.metadata.clientRecordVersion, 1);
              expect(record.metadata.device?.type, DeviceType.phone);
            },
          );

          test(
            'converts DistanceActivityRecordDto with null id to domain with '
            'none id',
            () {
              // Given
              final dto = DistanceActivityRecordDto(
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                distance: LengthDto(meters: 3000.0),
                activityType: DistanceActivityTypeDto.cycling,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.id, HealthRecordId.none);
              expect(record.distance.inMeters, 3000.0);
            },
          );

          test(
            'converts DistanceActivityRecordDto with different distance value',
            () {
              // Given
              final dto = DistanceActivityRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                distance: LengthDto(meters: 2000.0),
                activityType: DistanceActivityTypeDto.cycling,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.distance.inMeters, 2000.0);
              expect(
                record.metadata.recordingMethod,
                RecordingMethod.manualEntry,
              );
            },
          );
        },
      );
    },
  );
}
