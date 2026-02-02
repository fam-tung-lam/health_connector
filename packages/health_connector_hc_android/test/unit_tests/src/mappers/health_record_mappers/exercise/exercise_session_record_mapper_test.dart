import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/exercise/exercise_session_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

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
              const title = 'Morning Run';
              const notes = 'Great workout';

              final record = ExerciseSessionRecord.internal(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                exerciseType: ExerciseType.running,
                title: title,
                notes: notes,
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
              expect(dto.exerciseType, ExerciseTypeDto.running);
              expect(dto.title, title);
              expect(dto.notes, notes);
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
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
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
        'ExerciseSessionRecordFromDto',
        () {
          test(
            'converts ExerciseSessionRecordDto to ExerciseSessionRecord',
            () {
              const title = 'Bike Ride';
              const notes = 'Evening cycling';

              final dto = ExerciseSessionRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
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
                exerciseType: ExerciseTypeDto.cycling,
                title: title,
                notes: notes,
              );

              final record = dto.fromDto();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(record.exerciseType, ExerciseType.cycling);
              expect(record.title, title);
              expect(record.notes, notes);
            },
          );

          test(
            'converts ExerciseSessionRecordDto with null id to domain '
            'with none id',
            () {
              final dto = ExerciseSessionRecordDto(
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
                exerciseType: ExerciseTypeDto.walking,
              );

              final record = dto.fromDto();

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
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
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
                exerciseType: ExerciseTypeDto.cycling,
                exerciseRoute: routeDto,
              );

              final record = dto.fromDto();

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
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
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
                exerciseType: ExerciseTypeDto.walking,
              );

              final record = dto.fromDto();

              expect(record.exerciseRoute, isNull);
            },
          );
        },
      );
    },
  );
}
