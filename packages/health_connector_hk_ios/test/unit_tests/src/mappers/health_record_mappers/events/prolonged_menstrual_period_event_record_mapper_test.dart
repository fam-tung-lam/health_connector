import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/events/prolonged_menstrual_period_event_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'ProlongedMenstrualPeriodEventRecordMapper',
    () {
      group(
        'ProlongedMenstrualPeriodEventRecordDtoToDomain',
        () {
          test(
            'converts ProlongedMenstrualPeriodEventRecordDto to '
            'ProlongedMenstrualPeriodEventRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = ProlongedMenstrualPeriodEventRecordDto(
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
              expect(record.startTime, time.toUtc());
              expect(
                record.endTime,
                time.add(const Duration(minutes: 5)).toUtc(),
              );
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
