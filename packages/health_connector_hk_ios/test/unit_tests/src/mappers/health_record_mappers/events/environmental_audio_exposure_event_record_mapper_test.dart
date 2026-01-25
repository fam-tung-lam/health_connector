import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/events/environmental_audio_exposure_event_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'EnvironmentalAudioExposureEventRecordMapper',
    () {
      group(
        'EnvironmentalAudioExposureEventRecordDtoToDomain',
        () {
          test(
            'converts EnvironmentalAudioExposureEventRecordDto to '
            'EnvironmentalAudioExposureEventRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = EnvironmentalAudioExposureEventRecordDto(
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
                aWeightedDecibel: 80.0,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, time);
              expect(
                record.endTime,
                time.add(const Duration(minutes: 5)),
              );
              expect(record.aWeightedDecibel!.value, 80.0);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts EnvironmentalAudioExposureEventRecordDto with '
            'null aWeightedDecibel to EnvironmentalAudioExposureEventRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = EnvironmentalAudioExposureEventRecordDto(
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
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.aWeightedDecibel, null);
            },
          );
        },
      );
    },
  );
}
