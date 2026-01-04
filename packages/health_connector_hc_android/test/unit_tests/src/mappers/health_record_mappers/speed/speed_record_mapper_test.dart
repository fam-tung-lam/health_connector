import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/speed/speed_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  final fakeSampleTime = FakeData.fakeStartTime.add(
    const Duration(minutes: 30),
  );

  group(
    'SpeedSeriesRecordMapper',
    () {
      group(
        'SpeedSeriesRecordToDto',
        () {
          // Should
          test(
            'converts SpeedSeriesRecord to SpeedSeriesRecordDto',
            () {
              // Given
              final record = SpeedSeriesRecord(
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
                samples: [
                  SpeedMeasurement(
                    time: fakeSampleTime,
                    speed: const Velocity.metersPerSecond(2.5),
                  ),
                ],
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.id, FakeData.fakeId);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
              expect(
                dto.startZoneOffsetSeconds,
                FakeData.fakeStartTimeZoneOffsetSeconds,
              );
              expect(
                dto.endZoneOffsetSeconds,
                FakeData.fakeEndTimeZoneOffsetSeconds,
              );
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.samples, hasLength(1));
              expect(dto.samples[0].speed.value, 2.5);
            },
          );
        },
      );

      group(
        'SpeedSeriesRecordDtoToDomain',
        () {
          // Should
          test(
            'converts SpeedSeriesRecordDto to SpeedSeriesRecord',
            () {
              // Given
              final dto = SpeedSeriesRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                samples: [
                  SpeedMeasurementDto(
                    time: fakeSampleTime.millisecondsSinceEpoch,
                    speed: VelocityDto(
                      value: 3.0,
                      unit: VelocityUnitDto.metersPerSecond,
                    ),
                  ),
                ],
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(
                record.startZoneOffsetSeconds,
                FakeData.fakeStartTimeZoneOffsetSeconds,
              );
              expect(
                record.endZoneOffsetSeconds,
                FakeData.fakeEndTimeZoneOffsetSeconds,
              );
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(record.samples, hasLength(1));
              expect(record.samples[0].speed.inMetersPerSecond, 3.0);
            },
          );

          // Should
          test(
            'converts SpeedSeriesRecordDto with null id to domain with none id',
            () {
              // Given
              final dto = SpeedSeriesRecordDto(
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                samples: [],
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
