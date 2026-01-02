import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/speed_activity_record_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'SpeedActivityRecordMapper',
    () {
      group(
        'SpeedActivityRecordToDto',
        () {
          test(
            'converts WalkingSpeedRecord to SpeedActivityRecordDto',
            () {
              // Given
              final time = FakeData.fakeTime;

              final record = WalkingSpeedRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.watch),
                ),
                speed: const Velocity.metersPerSecond(1.5),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.id, FakeData.fakeId);
              expect(dto.time, time.millisecondsSinceEpoch);
              expect(dto.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
              expect(dto.speed.value, 1.5);
              expect(dto.speed.unit, VelocityUnitDto.metersPerSecond);
              expect(dto.activityType, SpeedActivityTypeDto.walking);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );

          test(
            'converts RunningSpeedRecord to SpeedActivityRecordDto',
            () {
              // Given
              final time = FakeData.fakeTime;

              final record = RunningSpeedRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.watch),
                ),
                speed: const Velocity.metersPerSecond(3.5),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.activityType, SpeedActivityTypeDto.running);
              expect(dto.speed.value, 3.5);
              expect(dto.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
            },
          );

          test(
            'converts StairAscentSpeedRecord to SpeedActivityRecordDto',
            () {
              // Given
              final time = FakeData.fakeTime;

              final record = StairAscentSpeedRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.watch),
                ),
                speed: const Velocity.metersPerSecond(0.8),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.activityType, SpeedActivityTypeDto.stairAscent);
              expect(dto.speed.value, 0.8);
            },
          );

          test(
            'converts StairDescentSpeedRecord to SpeedActivityRecordDto',
            () {
              // Given
              final time = FakeData.fakeTime;

              final record = StairDescentSpeedRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.watch),
                ),
                speed: const Velocity.metersPerSecond(1.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.activityType, SpeedActivityTypeDto.stairDescent);
              expect(dto.speed.value, 1.0);
            },
          );
        },
      );

      group(
        'SpeedActivityRecordDtoToDomain',
        () {
          test(
            'converts SpeedActivityRecordDto to WalkingSpeedRecord',
            () {
              // Given
              final time = FakeData.fakeTime;

              final dto = SpeedActivityRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                speed: VelocityDto(
                  value: 1.3,
                  unit: VelocityUnitDto.metersPerSecond,
                ),
                activityType: SpeedActivityTypeDto.walking,
              );

              // When
              final record = dto.toDomain() as WalkingSpeedRecord;

              // Then
              expect(record.id.value, FakeData.fakeId);
              expect(record.time, time);
              expect(record.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
              expect(record.speed.inMetersPerSecond, 1.3);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts SpeedActivityRecordDto to RunningSpeedRecord',
            () {
              // Given
              final time = FakeData.fakeTime;

              final dto = SpeedActivityRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                speed: VelocityDto(
                  value: 4.2,
                  unit: VelocityUnitDto.metersPerSecond,
                ),
                activityType: SpeedActivityTypeDto.running,
              );

              // When
              final record = dto.toDomain() as RunningSpeedRecord;

              // Then
              expect(record.speed.inMetersPerSecond, 4.2);
              expect(record.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
            },
          );

          test(
            'converts SpeedActivityRecordDto to StairAscentSpeedRecord',
            () {
              // Given
              final time = FakeData.fakeTime;

              final dto = SpeedActivityRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                speed: VelocityDto(
                  value: 0.7,
                  unit: VelocityUnitDto.metersPerSecond,
                ),
                activityType: SpeedActivityTypeDto.stairAscent,
              );

              // When
              final record = dto.toDomain() as StairAscentSpeedRecord;

              // Then
              expect(record.speed.inMetersPerSecond, 0.7);
            },
          );

          test(
            'converts SpeedActivityRecordDto to StairDescentSpeedRecord',
            () {
              // Given
              final time = FakeData.fakeTime;

              final dto = SpeedActivityRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                speed: VelocityDto(
                  value: 0.9,
                  unit: VelocityUnitDto.metersPerSecond,
                ),
                activityType: SpeedActivityTypeDto.stairDescent,
              );

              // When
              final record = dto.toDomain() as StairDescentSpeedRecord;

              // Then
              expect(record.speed.inMetersPerSecond, 0.9);
            },
          );

          test(
            'converts SpeedActivityRecordDto with null id to domain with '
            'none id',
            () {
              // Given
              final time = FakeData.fakeTime;

              final dto = SpeedActivityRecordDto(
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                speed: VelocityDto(
                  value: 1.2,
                  unit: VelocityUnitDto.metersPerSecond,
                ),
                activityType: SpeedActivityTypeDto.walking,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.id, HealthRecordId.none);
            },
          );
        },
      );
    },
  );
}
