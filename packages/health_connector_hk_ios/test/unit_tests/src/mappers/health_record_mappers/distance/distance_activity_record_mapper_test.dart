import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/distance_activity_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'DistanceActivityRecordMapper',
    () {
      group(
        'DistanceActivityRecordToDto',
        () {
          test(
            'dispatches CyclingDistanceRecord to correct mapper',
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
              expect(dto.activityType, DistanceActivityTypeDto.cycling);
              expect(dto.meters, 5000.0);
            },
          );

          test(
            'dispatches SwimmingDistanceRecord to correct mapper',
            () {
              // Given
              final record = SwimmingDistanceRecord(
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
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                distance: const Length.meters(1000.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.activityType, DistanceActivityTypeDto.swimming);
              expect(dto.meters, 1000.0);
            },
          );

          test(
            'dispatches WheelchairDistanceRecord to correct mapper',
            () {
              // Given
              final record = WheelchairDistanceRecord(
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
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                distance: const Length.meters(2000.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.activityType, DistanceActivityTypeDto.wheelchair);
              expect(dto.meters, 2000.0);
            },
          );

          test(
            'dispatches DownhillSnowSportsDistanceRecord to correct mapper',
            () {
              // Given
              final record = DownhillSnowSportsDistanceRecord(
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
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                distance: const Length.meters(3000.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(
                dto.activityType,
                DistanceActivityTypeDto.downhillSnowSports,
              );
              expect(dto.meters, 3000.0);
            },
          );

          test(
            'dispatches RowingDistanceRecord to correct mapper',
            () {
              // Given
              final record = RowingDistanceRecord(
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
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                distance: const Length.meters(4000.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.activityType, DistanceActivityTypeDto.rowing);
              expect(dto.meters, 4000.0);
            },
          );

          test(
            'dispatches PaddleSportsDistanceRecord to correct mapper',
            () {
              // Given
              final record = PaddleSportsDistanceRecord(
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
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                distance: const Length.meters(3500.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.activityType, DistanceActivityTypeDto.paddleSports);
              expect(dto.meters, 3500.0);
            },
          );

          test(
            'dispatches CrossCountrySkiingDistanceRecord to correct mapper',
            () {
              // Given
              final record = CrossCountrySkiingDistanceRecord(
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
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                distance: const Length.meters(8000.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(
                dto.activityType,
                DistanceActivityTypeDto.crossCountrySkiing,
              );
              expect(dto.meters, 8000.0);
            },
          );

          test(
            'dispatches SkatingSportsDistanceRecord to correct mapper',
            () {
              // Given
              final record = SkatingSportsDistanceRecord(
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
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                distance: const Length.meters(6000.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.activityType, DistanceActivityTypeDto.skatingSports);
              expect(dto.meters, 6000.0);
            },
          );

          test(
            'dispatches SixMinuteWalkTestDistanceRecord to correct mapper',
            () {
              // Given
              final record = SixMinuteWalkTestDistanceRecord(
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
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                distance: const Length.meters(500.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(
                dto.activityType,
                DistanceActivityTypeDto.sixMinuteWalkTest,
              );
              expect(dto.meters, 500.0);
            },
          );

          test(
            'dispatches WalkingRunningDistanceRecord to correct mapper',
            () {
              // Given
              final record = WalkingRunningDistanceRecord(
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
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                distance: const Length.meters(8000.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.activityType, DistanceActivityTypeDto.walkingRunning);
              expect(dto.meters, 8000.0);
            },
          );
        },
      );

      group(
        'DistanceActivityRecordDtoToDomain',
        () {
          test(
            'dispatches cycling type to CyclingDistanceRecord',
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
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                meters: 4500.0,
                activityType: DistanceActivityTypeDto.cycling,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<CyclingDistanceRecord>());
              expect(record.distance.inMeters, 4500.0);
            },
          );

          test(
            'dispatches swimming type to SwimmingDistanceRecord',
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
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                meters: 800.0,
                activityType: DistanceActivityTypeDto.swimming,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<SwimmingDistanceRecord>());
              expect(record.distance.inMeters, 800.0);
            },
          );

          test(
            'dispatches wheelchair type to WheelchairDistanceRecord',
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
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                meters: 1800.0,
                activityType: DistanceActivityTypeDto.wheelchair,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<WheelchairDistanceRecord>());
              expect(record.distance.inMeters, 1800.0);
            },
          );

          test(
            'dispatches downhillSnowSports type to '
            'DownhillSnowSportsDistanceRecord',
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
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                meters: 2500.0,
                activityType: DistanceActivityTypeDto.downhillSnowSports,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<DownhillSnowSportsDistanceRecord>());
              expect(record.distance.inMeters, 2500.0);
            },
          );

          test(
            'dispatches rowing type to RowingDistanceRecord',
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
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                meters: 3500.0,
                activityType: DistanceActivityTypeDto.rowing,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<RowingDistanceRecord>());
              expect(record.distance.inMeters, 3500.0);
            },
          );

          test(
            'dispatches paddleSports type to PaddleSportsDistanceRecord',
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
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                meters: 2800.0,
                activityType: DistanceActivityTypeDto.paddleSports,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<PaddleSportsDistanceRecord>());
              expect(record.distance.inMeters, 2800.0);
            },
          );

          test(
            'dispatches crossCountrySkiing type to '
            'CrossCountrySkiingDistanceRecord',
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
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                meters: 7500.0,
                activityType: DistanceActivityTypeDto.crossCountrySkiing,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<CrossCountrySkiingDistanceRecord>());
              expect(record.distance.inMeters, 7500.0);
            },
          );

          test(
            'dispatches skatingSports type to SkatingSportsDistanceRecord',
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
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                meters: 5500.0,
                activityType: DistanceActivityTypeDto.skatingSports,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<SkatingSportsDistanceRecord>());
              expect(record.distance.inMeters, 5500.0);
            },
          );

          test(
            'dispatches sixMinuteWalkTest type to '
            'SixMinuteWalkTestDistanceRecord',
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
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                meters: 450.0,
                activityType: DistanceActivityTypeDto.sixMinuteWalkTest,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<SixMinuteWalkTestDistanceRecord>());
              expect(record.distance.inMeters, 450.0);
            },
          );

          test(
            'dispatches walkingRunning type to WalkingRunningDistanceRecord',
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
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                meters: 7000.0,
                activityType: DistanceActivityTypeDto.walkingRunning,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<WalkingRunningDistanceRecord>());
              expect(record.distance.inMeters, 7000.0);
            },
          );
        },
      );
    },
  );
}
