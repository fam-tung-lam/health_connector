import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/activity/low_cardio_fitness_event_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'LowCardioFitnessEventRecordMapper',
    () {
      group(
        'LowCardioFitnessEventRecordDtoToDomain',
        () {
          test(
            'converts LowCardioFitnessEventRecordDto to LowCardioFitnessEventRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = LowCardioFitnessEventRecordDto(
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
                vo2MlPerMinPerKg: 35.5,
                vo2MlPerMinPerKgThreshold: 30.0,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, time);
              expect(
                record.endTime,
                time.add(const Duration(minutes: 5)),
              );
              expect(record.vo2MlPerMinPerKg!.value, 35.5);
              expect(record.vo2MlPerMinPerKgThreshold!.value, 30.0);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts LowCardioFitnessEventRecordDto with null values to LowCardioFitnessEventRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = LowCardioFitnessEventRecordDto(
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
                vo2MlPerMinPerKg: null,
                vo2MlPerMinPerKgThreshold: null,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.vo2MlPerMinPerKg, null);
              expect(record.vo2MlPerMinPerKgThreshold, null);
            },
          );
        },
      );
    },
  );
}
