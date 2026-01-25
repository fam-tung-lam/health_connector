import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/headphone_audio_exposure_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'HeadphoneAudioExposureRecordMapper',
    () {
      group(
        'HeadphoneAudioExposureRecordToDto',
        () {
          test(
            'converts HeadphoneAudioExposureRecord to HeadphoneAudioExposureRecordDto',
            () {
              final time = FakeData.fakeTime;

              final record = HeadphoneAudioExposureRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: time,
                endTime: time.add(const Duration(minutes: 5)),
                startZoneOffsetSeconds: 3_600,
                endZoneOffsetSeconds: 3_600,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                aWeightedDecibel: const Number(60),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.startTime, time.millisecondsSinceEpoch);
              expect(
                dto.endTime,
                time.add(const Duration(minutes: 5)).millisecondsSinceEpoch,
              );
              expect(dto.startZoneOffsetSeconds, 3_600);
              expect(dto.endZoneOffsetSeconds, 3_600);
              expect(dto.aWeightedDecibel, 60.0);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'HeadphoneAudioExposureRecordDtoToDomain',
        () {
          test(
            'converts HeadphoneAudioExposureRecordDto to HeadphoneAudioExposureRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = HeadphoneAudioExposureRecordDto(
                id: FakeData.fakeId,
                startTime: time.millisecondsSinceEpoch,
                endTime: time
                    .add(const Duration(minutes: 5))
                    .millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                aWeightedDecibel: 60.0,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, time);
              expect(
                record.endTime,
                time.add(const Duration(minutes: 5)),
              );
              expect(record.aWeightedDecibel.value, 60.0);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );
        },
      );
    },
  );
}
