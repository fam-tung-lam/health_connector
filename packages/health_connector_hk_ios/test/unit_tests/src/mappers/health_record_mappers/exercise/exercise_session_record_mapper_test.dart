import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/exercise/exercise_session_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'ExerciseSessionRecordMapper',
    () {
      group(
        'ExerciseSessionRecordToDto',
        () {
          test(
            'converts ExerciseSessionRecord to ExerciseSessionRecordDto',
            () {
              final record = ExerciseSessionRecord.internal(
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
                exerciseType: ExerciseType.running,
                title: 'Morning Run',
                notes: 'Felt great!',
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
              expect(dto.exerciseType, ExerciseTypeDto.running);
              expect(dto.title, 'Morning Run');
              expect(dto.notes, 'Felt great!');
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );

          test(
            'converts ExerciseSessionRecord with exerciseRoute to '
            'ExerciseSessionRecordDto',
            () {
              final location1 = ExerciseRouteLocation.internal(
                time: FakeData.fakeStartTime,
                latitude: FakeData.fakeLatitude,
                longitude: FakeData.fakeLongitude,
                altitude: const Length.meters(FakeData.fakeAltitudeInMeters),
                horizontalAccuracy: const Length.meters(
                  FakeData.fakeHorizontalAccuracyInMeters,
                ),
                verticalAccuracy: const Length.meters(
                  FakeData.fakeVerticalAccuracyInMeters,
                ),
              );
              final location2 = ExerciseRouteLocation.internal(
                time: FakeData.fakeEndTime,
                latitude: 37.7850,
                longitude: -122.4094,
              );
              final route = ExerciseRoute.internal([location1, location2]);

              final record = ExerciseSessionRecord.internal(
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
                exerciseType: ExerciseType.running,
                exerciseRoute: route,
              );

              final dto = record.toDto();

              expect(dto.exerciseRoute, isNotNull);
              expect(dto.exerciseRoute!.locations, hasLength(2));
              expect(
                dto.exerciseRoute!.locations[0].latitude,
                FakeData.fakeLatitude,
              );
              expect(
                dto.exerciseRoute!.locations[0].longitude,
                FakeData.fakeLongitude,
              );
              expect(
                dto.exerciseRoute!.locations[0].altitudeMeters,
                FakeData.fakeAltitudeInMeters,
              );
              expect(
                dto.exerciseRoute!.locations[0].horizontalAccuracyMeters,
                FakeData.fakeHorizontalAccuracyInMeters,
              );
              expect(
                dto.exerciseRoute!.locations[0].verticalAccuracyMeters,
                FakeData.fakeVerticalAccuracyInMeters,
              );
              expect(dto.exerciseRoute!.locations[1].latitude, 37.7850);
              expect(dto.exerciseRoute!.locations[1].longitude, -122.4094);
            },
          );
        },
      );

      group(
        'ExerciseSessionRecordDtoToDomain',
        () {
          test(
            'converts ExerciseSessionRecordDto to ExerciseSessionRecord',
            () {
              final dto = ExerciseSessionRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                exerciseType: ExerciseTypeDto.yoga,
                title: 'Evening Yoga',
                notes: 'Relaxing',
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(record.exerciseType, ExerciseType.yoga);
              expect(record.title, 'Evening Yoga');
              expect(record.notes, 'Relaxing');
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts ExerciseSessionRecordDto with null id to '
            'domain with none id',
            () {
              final dto = ExerciseSessionRecordDto(
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                exerciseType: ExerciseTypeDto.swimming,
              );

              final record = dto.toDomain();

              expect(record.id, HealthRecordId.none);
            },
          );

          test(
            'converts ExerciseSessionRecordDto with exerciseRoute to '
            'ExerciseSessionRecord',
            () {
              final location1 = ExerciseRouteLocationDto(
                time: FakeData.fakeStartTime.millisecondsSinceEpoch,
                latitude: FakeData.fakeLatitude,
                longitude: FakeData.fakeLongitude,
                altitudeMeters: FakeData.fakeAltitudeInMeters,
                horizontalAccuracyMeters:
                    FakeData.fakeHorizontalAccuracyInMeters,
                verticalAccuracyMeters: FakeData.fakeVerticalAccuracyInMeters,
              );
              final location2 = ExerciseRouteLocationDto(
                time: FakeData.fakeEndTime.millisecondsSinceEpoch,
                latitude: 37.7850,
                longitude: -122.4094,
              );
              final routeDto = ExerciseRouteDto(
                locations: [location1, location2],
              );

              final dto = ExerciseSessionRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                exerciseType: ExerciseTypeDto.yoga,
                exerciseRoute: routeDto,
              );

              final record = dto.toDomain();

              expect(record.exerciseRoute, isNotNull);
              expect(record.exerciseRoute!.locations, hasLength(2));
              expect(
                record.exerciseRoute!.locations[0].latitude,
                FakeData.fakeLatitude,
              );
              expect(
                record.exerciseRoute!.locations[0].longitude,
                FakeData.fakeLongitude,
              );
              expect(
                record.exerciseRoute!.locations[0].altitude?.inMeters,
                FakeData.fakeAltitudeInMeters,
              );
              expect(
                record.exerciseRoute!.locations[0].horizontalAccuracy?.inMeters,
                FakeData.fakeHorizontalAccuracyInMeters,
              );
              expect(
                record.exerciseRoute!.locations[0].verticalAccuracy?.inMeters,
                FakeData.fakeVerticalAccuracyInMeters,
              );
              expect(record.exerciseRoute!.locations[1].latitude, 37.7850);
              expect(record.exerciseRoute!.locations[1].longitude, -122.4094);
            },
          );

          test(
            'converts ExerciseSessionRecordDto with null exerciseRoute to '
            'domain with null route',
            () {
              final dto = ExerciseSessionRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                exerciseType: ExerciseTypeDto.swimming,
              );

              final record = dto.toDomain();

              expect(record.exerciseRoute, isNull);
            },
          );
        },
      );
    },
  );
}
