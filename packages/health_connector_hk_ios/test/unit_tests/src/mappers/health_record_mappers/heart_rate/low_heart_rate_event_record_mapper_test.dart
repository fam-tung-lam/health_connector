import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate/low_heart_rate_event_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'LowHeartRateEventRecordMapper',
    () {
      group(
        'LowHeartRateEventRecordDtoToDomain',
        () {
          test(
            'converts LowHeartRateEventRecordDto to LowHeartRateEventRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = LowHeartRateEventRecordDto(
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
                beatsPerMinuteThreshold: 50.0,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, time.toLocal());
              expect(
                record.endTime,
                time.add(const Duration(minutes: 5)).toLocal(),
              );
              expect(record.rateThreshold!.inPerMinute, 50.0);
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
