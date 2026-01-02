import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/mindfulness_session_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'MindfulnessSessionRecordMapper',
    () {
      group(
        'MindfulnessSessionRecordToDto',
        () {
          test(
            'converts MindfulnessSessionRecord to DTO',
            () {
              final startTime = DateTime(2025, 1, 15, 10).toUtc();
              final endTime = DateTime(2025, 1, 15, 10, 20).toUtc();
              const title = 'Morning Meditation';
              const notes = 'Peaceful session';

              final record = MindfulnessSessionRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: startTime,
                endTime: endTime,
                startZoneOffsetSeconds: 3_600,
                endZoneOffsetSeconds: 3_600,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.phone),
                ),
                sessionType: MindfulnessSessionType.meditation,
                title: title,
                notes: notes,
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.startTime, startTime.millisecondsSinceEpoch);
              expect(dto.endTime, endTime.millisecondsSinceEpoch);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.sessionType, MindfulnessSessionTypeDto.meditation);
              expect(dto.title, title);
              expect(dto.notes, notes);
            },
          );
        },
      );

      group(
        'MindfulnessSessionRecordDtoToDomain',
        () {
          test(
            'converts DTO to MindfulnessSessionRecord',
            () {
              final startTime = DateTime(2025, 1, 15, 10).toUtc();
              final endTime = DateTime(2025, 1, 15, 10, 15).toUtc();
              const title = 'Breathing Exercise';
              const notes = 'Relaxing';

              final dto = MindfulnessSessionRecordDto(
                id: FakeData.fakeId,
                startTime: startTime.millisecondsSinceEpoch,
                endTime: endTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                sessionType: MindfulnessSessionTypeDto.breathing,
                title: title,
                notes: notes,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, startTime);
              expect(record.endTime, endTime);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(record.sessionType, MindfulnessSessionType.breathing);
              expect(record.title, title);
              expect(record.notes, notes);
            },
          );

          test(
            'converts DTO with null id to domain with none id',
            () {
              final startTime = DateTime(2025, 1, 15, 10).toUtc();
              final endTime = DateTime(2025, 1, 15, 10, 10).toUtc();

              final dto = MindfulnessSessionRecordDto(
                startTime: startTime.millisecondsSinceEpoch,
                endTime: endTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                sessionType: MindfulnessSessionTypeDto.unknown,
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
