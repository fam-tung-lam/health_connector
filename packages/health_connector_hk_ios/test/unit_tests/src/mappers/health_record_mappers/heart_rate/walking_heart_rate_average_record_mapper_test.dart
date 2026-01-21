import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate/walking_heart_rate_average_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'WalkingHeartRateAverageRecordMapper',
    () {
      group(
        'WalkingHeartRateAverageRecordDtoToDomain',
        () {
          test(
            'converts WalkingHeartRateAverageRecordDto to '
            'WalkingHeartRateAverageRecord',
            () {
              final startTime = FakeData.fakeTime;
              final endTime = FakeData.fakeTime.add(
                const Duration(minutes: 30),
              );

              final dto = WalkingHeartRateAverageRecordDto(
                id: FakeData.fakeId,
                startTime: startTime.millisecondsSinceEpoch,
                endTime: endTime.millisecondsSinceEpoch,
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
                beatsPerMinute: 92.0,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, startTime);
              expect(record.endTime, endTime);
              expect(record.rate.inPerMinute, 92.0);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts WalkingHeartRateAverageRecordDto with null id to '
            'domain with none id',
            () {
              final startTime = FakeData.fakeTime;
              final endTime = FakeData.fakeTime.add(
                const Duration(minutes: 30),
              );

              final dto = WalkingHeartRateAverageRecordDto(
                startTime: startTime.millisecondsSinceEpoch,
                endTime: endTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                beatsPerMinute: 88.0,
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
