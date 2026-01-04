import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/speed/walking_speed_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'WalkingSpeedRecordMapper',
    () {
      group(
        'WalkingSpeedRecordToDto',
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
              expect(
                dto.metadata.recordingMethod,
                RecordingMethodDto.activelyRecorded,
              );
              expect(dto.metadata.clientRecordVersion, 1);
              expect(dto.metadata.deviceType, DeviceTypeDto.watch);
            },
          );

          test(
            'converts WalkingSpeedRecord with different speed value',
            () {
              // Given
              final time = FakeData.fakeTime;

              final record = WalkingSpeedRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 2,
                  device: Device(type: DeviceType.phone),
                ),
                speed: const Velocity.metersPerSecond(2.3),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.speed.value, 2.3);
              expect(dto.activityType, SpeedActivityTypeDto.walking);
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
        'WalkingSpeedRecordDtoToDomain',
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
              final record = dto.toDomain();

              // Then
              expect(record, isA<WalkingSpeedRecord>());
              expect(record.id.value, FakeData.fakeId);
              expect(record.time, time);
              expect(record.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
              expect(record.speed.inMetersPerSecond, 1.3);
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
              expect(record.speed.inMetersPerSecond, 1.2);
            },
          );

          test(
            'converts SpeedActivityRecordDto with different speed value',
            () {
              // Given
              final time = FakeData.fakeTime;

              final dto = SpeedActivityRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                speed: VelocityDto(
                  value: 0.8,
                  unit: VelocityUnitDto.metersPerSecond,
                ),
                activityType: SpeedActivityTypeDto.walking,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.speed.inMetersPerSecond, 0.8);
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
