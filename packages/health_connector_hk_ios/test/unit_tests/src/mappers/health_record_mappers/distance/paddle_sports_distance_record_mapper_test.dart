import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/paddle_sports_distance_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'PaddleSportsDistanceRecordMapper',
    () {
      group(
        'PaddleSportsDistanceRecordToDto',
        () {
          test(
            'converts PaddleSportsDistanceRecord to '
            'DistanceActivityRecordDto',
            () {
              // Given
              final record = PaddleSportsDistanceRecord(
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
                distance: const Length.meters(3500.0),
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
              expect(dto.distance.value, 3500.0);
              expect(dto.distance.unit, LengthUnitDto.meters);
              expect(dto.activityType, DistanceActivityTypeDto.paddleSports);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );

          test(
            'converts PaddleSportsDistanceRecord with different distance value',
            () {
              // Given
              final record = PaddleSportsDistanceRecord(
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
                distance: const Length.meters(7000.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.distance.value, 7000.0);
              expect(dto.activityType, DistanceActivityTypeDto.paddleSports);
            },
          );
        },
      );

      group(
        'PaddleSportsDistanceRecordDtoToDomain',
        () {
          test(
            'converts DistanceActivityRecordDto to '
            'PaddleSportsDistanceRecord',
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
                distance: LengthDto(value: 2800.0, unit: LengthUnitDto.meters),
                activityType: DistanceActivityTypeDto.paddleSports,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<PaddleSportsDistanceRecord>());
              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(record.distance.inMeters, 2800.0);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
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
                distance: LengthDto(value: 6500.0, unit: LengthUnitDto.meters),
                activityType: DistanceActivityTypeDto.paddleSports,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.id, HealthRecordId.none);
              expect(record.distance.inMeters, 6500.0);
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
                distance: LengthDto(value: 1800.0, unit: LengthUnitDto.meters),
                activityType: DistanceActivityTypeDto.paddleSports,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.distance.inMeters, 1800.0);
            },
          );
        },
      );
    },
  );
}
