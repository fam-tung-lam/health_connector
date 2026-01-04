import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/speed/speed_activity_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'SpeedActivityRecordMapper',
    () {
      group(
        'SpeedActivityRecordToDto',
        () {
          test(
            'dispatches WalkingSpeedRecord to correct mapper',
            () {
              // Given
              final record = WalkingSpeedRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: FakeData.fakeTime,
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
              expect(dto.activityType, SpeedActivityTypeDto.walking);
              expect(dto.speed.value, 1.5);
            },
          );

          test(
            'dispatches RunningSpeedRecord to correct mapper',
            () {
              // Given
              final record = RunningSpeedRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: FakeData.fakeTime,
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
            },
          );

          test(
            'dispatches StairAscentSpeedRecord to correct mapper',
            () {
              // Given
              final record = StairAscentSpeedRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: FakeData.fakeTime,
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
            'dispatches StairDescentSpeedRecord to correct mapper',
            () {
              // Given
              final record = StairDescentSpeedRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: FakeData.fakeTime,
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
            'dispatches walking type to WalkingSpeedRecord',
            () {
              // Given
              final dto = SpeedActivityRecordDto(
                id: FakeData.fakeId,
                time: FakeData.fakeTime.millisecondsSinceEpoch,
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
              final record = dto.toDomain();

              // Then
              expect(record, isA<WalkingSpeedRecord>());
              expect(record.speed.inMetersPerSecond, 1.3);
            },
          );

          test(
            'dispatches running type to RunningSpeedRecord',
            () {
              // Given
              final dto = SpeedActivityRecordDto(
                id: FakeData.fakeId,
                time: FakeData.fakeTime.millisecondsSinceEpoch,
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
              final record = dto.toDomain();

              // Then
              expect(record, isA<RunningSpeedRecord>());
              expect(record.speed.inMetersPerSecond, 4.2);
            },
          );

          test(
            'dispatches stairAscent type to StairAscentSpeedRecord',
            () {
              // Given
              final dto = SpeedActivityRecordDto(
                id: FakeData.fakeId,
                time: FakeData.fakeTime.millisecondsSinceEpoch,
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
              final record = dto.toDomain();

              // Then
              expect(record, isA<StairAscentSpeedRecord>());
              expect(record.speed.inMetersPerSecond, 0.7);
            },
          );

          test(
            'dispatches stairDescent type to StairDescentSpeedRecord',
            () {
              // Given
              final dto = SpeedActivityRecordDto(
                id: FakeData.fakeId,
                time: FakeData.fakeTime.millisecondsSinceEpoch,
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
              final record = dto.toDomain();

              // Then
              expect(record, isA<StairDescentSpeedRecord>());
              expect(record.speed.inMetersPerSecond, 0.9);
            },
          );
        },
      );
    },
  );
}
