import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/swimming_distance_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'SwimmingDistanceRecordMapper',
    () {
      group(
        'SwimmingDistanceRecordToDto',
        () {
          test(
            'converts SwimmingDistanceRecord to DistanceActivityRecordDto',
            () {
              // Given
              final record = SwimmingDistanceRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.watch),
                ),
                distance: const Length.meters(1000.0),
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
                dto.zoneOffsetSeconds,
                FakeData.fakeStartTimeZoneOffsetSeconds,
              );
              expect(dto.distance.value, 1000.0);
              expect(dto.distance.unit, LengthUnitDto.meters);
              expect(dto.activityType, DistanceActivityTypeDto.swimming);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(
                dto.metadata.recordingMethod,
                RecordingMethodDto.activelyRecorded,
              );
              expect(dto.metadata.clientRecordVersion, 1);
              expect(dto.metadata.deviceType, DeviceTypeDto.watch);
            },
          );

          test(
            'converts SwimmingDistanceRecord with different distance value',
            () {
              // Given
              final record = SwimmingDistanceRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 2,
                  device: Device(type: DeviceType.phone),
                ),
                distance: const Length.meters(500.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.distance.value, 500.0);
              expect(dto.activityType, DistanceActivityTypeDto.swimming);
              expect(
                dto.metadata.recordingMethod,
                RecordingMethodDto.manualEntry,
              );
              expect(dto.metadata.deviceType, DeviceTypeDto.phone);
            },
          );
        },
      );

      group(
        'SwimmingDistanceRecordDtoToDomain',
        () {
          test(
            'converts DistanceActivityRecordDto to SwimmingDistanceRecord',
            () {
              // Given
              final dto = DistanceActivityRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                distance: LengthDto(value: 800.0, unit: LengthUnitDto.meters),
                activityType: DistanceActivityTypeDto.swimming,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<SwimmingDistanceRecord>());
              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(
                record.startZoneOffsetSeconds,
                FakeData.fakeStartTimeZoneOffsetSeconds,
              );
              expect(
                record.endZoneOffsetSeconds,
                FakeData.fakeStartTimeZoneOffsetSeconds,
              );
              expect(record.distance.inMeters, 800.0);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(
                record.metadata.recordingMethod,
                RecordingMethod.activelyRecorded,
              );
              expect(record.metadata.clientRecordVersion, 1);
              expect(record.metadata.device?.type, DeviceType.watch);
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
                zoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                distance: LengthDto(value: 1500.0, unit: LengthUnitDto.meters),
                activityType: DistanceActivityTypeDto.swimming,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.id, HealthRecordId.none);
              expect(record.distance.inMeters, 1500.0);
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
                zoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                distance: LengthDto(value: 200.0, unit: LengthUnitDto.meters),
                activityType: DistanceActivityTypeDto.swimming,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.distance.inMeters, 200.0);
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
