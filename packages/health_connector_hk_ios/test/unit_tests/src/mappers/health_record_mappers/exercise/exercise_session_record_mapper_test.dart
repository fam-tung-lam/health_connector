import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/exercise/exercise_session_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

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
              final record = ExerciseSessionRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.phone),
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
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
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
                record.metadata.dataOrigin.packageName,
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
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
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
        },
      );
    },
  );
}
