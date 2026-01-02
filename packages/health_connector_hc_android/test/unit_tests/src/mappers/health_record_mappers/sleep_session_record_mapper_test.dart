import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/sleep_session_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

void main() {
  final fakeStage1StartTime = FakeData.fakeStartTime.add(
    const Duration(hours: 1),
  );
  final fakeStage1EndTime = FakeData.fakeStartTime.add(
    const Duration(hours: 3),
  );

  group(
    'SleepSessionRecordMapper',
    () {
      group(
        'SleepSessionRecordToDto',
        () {
          test(
            'converts SleepSessionRecord to SleepSessionRecordDto',
            () {
              const title = 'Night Sleep';
              const notes = 'Good rest';

              final record = SleepSessionRecord(
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
                  SleepStage(
                    startTime: fakeStage1StartTime,
                    endTime: fakeStage1EndTime,
                    stageType: SleepStageType.deep,
                  ),
                ],
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
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.stages, hasLength(1));
              expect(dto.stages[0].stage, SleepStageTypeDto.deep);
              expect(dto.title, title);
              expect(dto.notes, notes);
            },
          );
        },
      );

      group(
        'SleepSessionRecordDtoToDomain',
        () {
          test(
            'converts SleepSessionRecordDto to SleepSessionRecord',
            () {
              const title = 'Afternoon Nap';

              final dto = SleepSessionRecordDto(
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
                stages: [
                  SleepStageDto(
                    startTime: fakeStage1StartTime.millisecondsSinceEpoch,
                    endTime: fakeStage1EndTime.millisecondsSinceEpoch,
                    stage: SleepStageTypeDto.rem,
                  ),
                ],
                title: title,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(record.samples, hasLength(1));
              expect(record.samples[0].stageType, SleepStageType.rem);
              expect(record.title, title);
            },
          );

          test(
            'converts SleepSessionRecordDto with null id to '
            'domain with none id',
            () {
              final dto = SleepSessionRecordDto(
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
                stages: [],
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
