import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/vo2_max_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'Vo2MaxRecordMapper',
    () {
      group(
        'Vo2MaxRecordToDto',
        () {
          test(
            'converts Vo2MaxRecord to Vo2MaxRecordDto',
            () {
              final time = FakeData.fakeTime;

              final record = Vo2MaxRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.watch),
                ),
                mLPerKgPerMin: const Number(45.5),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, time.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(dto.mLPerKgPerMin.value, 45.5);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'Vo2MaxRecordDtoToDomain',
        () {
          test(
            'converts Vo2MaxRecordDto to Vo2MaxRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = Vo2MaxRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                mLPerKgPerMin: NumberDto(value: 42.3),
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, time);
              expect(record.mLPerKgPerMin.value, 42.3);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts Vo2MaxRecordDto with null id to domain with none id',
            () {
              final time = FakeData.fakeTime;

              final dto = Vo2MaxRecordDto(
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                mLPerKgPerMin: NumberDto(value: 38.0),
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
