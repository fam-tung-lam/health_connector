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

              final record = ExerciseSessionRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.watch),
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
        },
      );
    },
  );
}
