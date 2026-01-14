import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate/resting_heart_rate_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'RestingHeartRateRecordMapper',
    () {
      group(
        'RestingHeartRateRecordToDto',
        () {
          test(
            'converts RestingHeartRateRecord to RestingHeartRateRecordDto',
            () {
              final time = FakeData.fakeTime;

              final record = RestingHeartRateRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                rate: Frequency.perMinute(58.0),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, time.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(dto.beatsPerMinute, 58.0);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'RestingHeartRateRecordDtoToDomain',
        () {
          test(
            'converts RestingHeartRateRecordDto to RestingHeartRateRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = RestingHeartRateRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                beatsPerMinute: 62.0,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, time);
              expect(record.rate.inPerMinute, 62.0);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts RestingHeartRateRecordDto with null id to '
            'domain with none id',
            () {
              final time = FakeData.fakeTime;

              final dto = RestingHeartRateRecordDto(
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                beatsPerMinute: 60.0,
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
