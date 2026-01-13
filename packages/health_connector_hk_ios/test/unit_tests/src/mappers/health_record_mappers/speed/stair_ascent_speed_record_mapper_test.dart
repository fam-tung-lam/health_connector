import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/speed/stair_ascent_speed_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'StairAscentSpeedRecordMapper',
    () {
      group(
        'StairAscentSpeedRecordToDto',
        () {
          test(
            'converts StairAscentSpeedRecord to SpeedActivityRecordDto',
            () {
              // Given
              final time = FakeData.fakeTime;

              final record = StairAscentSpeedRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                speed: const Velocity.metersPerSecond(0.5),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.id, FakeData.fakeId);
              expect(dto.time, time.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(dto.speed.metersPerSecond, 0.5);

              expect(dto.activityType, SpeedActivityTypeDto.stairAscent);
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
            'converts StairAscentSpeedRecord with different speed value',
            () {
              // Given
              final time = FakeData.fakeTime;

              final record = StairAscentSpeedRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 2,
                  device: const Device(type: DeviceType.phone),
                ),
                speed: const Velocity.metersPerSecond(0.4),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.speed.metersPerSecond, 0.4);
              expect(dto.activityType, SpeedActivityTypeDto.stairAscent);
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
        'StairAscentSpeedRecordDtoToDomain',
        () {
          test(
            'converts SpeedActivityRecordDto to StairAscentSpeedRecord',
            () {
              // Given
              final time = FakeData.fakeTime;

              final dto = SpeedActivityRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                speed: VelocityDto(metersPerSecond: 0.5),
                activityType: SpeedActivityTypeDto.stairAscent,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<StairAscentSpeedRecord>());
              expect(record.id.value, FakeData.fakeId);
              expect(record.time, time);
              expect(
                record.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(record.speed.inMetersPerSecond, 0.5);
              expect(
                record.metadata.dataOrigin?.packageName,
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
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                speed: VelocityDto(metersPerSecond: 0.4),
                activityType: SpeedActivityTypeDto.stairAscent,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.id, HealthRecordId.none);
              expect(record.speed.inMetersPerSecond, 0.4);
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
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                speed: VelocityDto(metersPerSecond: 0.3),
                activityType: SpeedActivityTypeDto.stairAscent,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.speed.inMetersPerSecond, 0.3);
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
