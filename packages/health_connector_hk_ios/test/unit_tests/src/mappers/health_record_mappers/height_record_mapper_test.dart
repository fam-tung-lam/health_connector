import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/height_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'HeightRecordMapper',
    () {
      group(
        'HeightRecordToDto',
        () {
          test(
            'converts HeightRecord to HeightRecordDto',
            () {
              final time = FakeData.fakeTime;

              final record = HeightRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.phone),
                ),
                height: const Length.meters(1.75),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, time.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(dto.height.meters, 1.75);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'HeightRecordDtoToDomain',
        () {
          test(
            'converts HeightRecordDto to HeightRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = HeightRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                height: LengthDto(meters: 1.82),
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, time);
              expect(record.height.inMeters, 1.82);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts HeightRecordDto with null id to domain with none id',
            () {
              final time = FakeData.fakeTime;

              final dto = HeightRecordDto(
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                height: LengthDto(meters: 1.68),
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
