import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/activity_intensity/activity_intensity_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'ActivityIntensityRecordMapper',
    () {
      group(
        'ActivityIntensityRecordToDto',
        () {
          test(
            'converts ActivityIntensityRecord to ActivityIntensityRecordDto',
            () {
              const title = 'High Intensity Workout';
              const notes = 'Very tiring';

              final record = ActivityIntensityRecord.internal(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                activityIntensityType: ActivityIntensityType.vigorous,
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
              expect(
                dto.activityIntensityType,
                ActivityIntensityTypeDto.vigorous,
              );
              expect(dto.title, title);
              expect(dto.notes, notes);
            },
          );
        },
      );

      group(
        'ActivityIntensityRecordDtoToDomain',
        () {
          test(
            'converts ActivityIntensityRecordDto to ActivityIntensityRecord',
            () {
              const title = 'Moderate Walk';
              const notes = 'Relaxing';

              final dto = ActivityIntensityRecordDto(
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
                activityIntensityType: ActivityIntensityTypeDto.moderate,
                title: title,
                notes: notes,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(
                record.activityIntensityType,
                ActivityIntensityType.moderate,
              );
              expect(record.title, title);
              expect(record.notes, notes);
            },
          );

          test(
            'converts ActivityIntensityRecordDto with null id to domain '
            'with none id',
            () {
              final dto = ActivityIntensityRecordDto(
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
                activityIntensityType: ActivityIntensityTypeDto.moderate,
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
