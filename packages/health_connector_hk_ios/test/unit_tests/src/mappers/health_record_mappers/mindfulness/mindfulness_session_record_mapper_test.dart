import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/mindfulness/mindfulness_session_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'MindfulnessSessionRecordMapper',
    () {
      group(
        'MindfulnessSessionRecordToDto',
        () {
          test(
            'converts MindfulnessSessionRecord to MindfulnessSessionRecordDto',
            () {
              final record = MindfulnessSessionRecord(
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
                sessionType: MindfulnessSessionType.meditation,
                title: 'Morning Meditation',
                notes: 'Peaceful',
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
              expect(dto.sessionType, MindfulnessSessionTypeDto.meditation);
              expect(dto.title, 'Morning Meditation');
              expect(dto.notes, 'Peaceful');
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'MindfulnessSessionRecordDtoToDomain',
        () {
          test(
            'converts MindfulnessSessionRecordDto to MindfulnessSessionRecord',
            () {
              final dto = MindfulnessSessionRecordDto(
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
                sessionType: MindfulnessSessionTypeDto.breathing,
                title: 'Breathing Exercise',
                notes: 'Calm',
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(record.sessionType, MindfulnessSessionType.breathing);
              expect(record.title, 'Breathing Exercise');
              expect(record.notes, 'Calm');
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts MindfulnessSessionRecordDto with null id to '
            'domain with none id',
            () {
              final dto = MindfulnessSessionRecordDto(
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
                sessionType: MindfulnessSessionTypeDto.music,
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
