import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/events/infrequent_menstrual_cycle_event_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'InfrequentMenstrualCycleEventRecordMapper',
    () {
      group(
        'InfrequentMenstrualCycleEventRecordDtoToDomain',
        () {
          test(
            'converts InfrequentMenstrualCycleEventRecordDto to '
            'InfrequentMenstrualCycleEventRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = InfrequentMenstrualCycleEventRecordDto(
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
              expect(record.startTime, time);
              expect(
                record.endTime,
                time.add(const Duration(minutes: 5)),
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
