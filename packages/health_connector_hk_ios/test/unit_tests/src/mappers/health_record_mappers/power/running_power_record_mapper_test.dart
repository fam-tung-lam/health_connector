import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/power/running_power_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group('RunningPowerRecordMapper', () {
    group('toDto', () {
      test('converts RunningPowerRecord to RunningPowerRecordDto', () {
        final record = RunningPowerRecord(
          id: HealthRecordId(FakeData.fakeId),
          time: FakeData.fakeStartTime,
          zoneOffsetSeconds: FakeData.fakeStartTime.timeZoneOffset.inSeconds,
          metadata: Metadata.internal(
            dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
            recordingMethod: RecordingMethod.activelyRecorded,
            clientRecordVersion: 1,
            device: const Device(type: DeviceType.phone),
          ),
          power: const Power.watts(250),
        );

        final dto = record.toDto();

        expect(dto.id, FakeData.fakeId);
        expect(
          dto.time,
          FakeData.fakeStartTime.millisecondsSinceEpoch,
        );
        expect(
          dto.zoneOffsetSeconds,
          FakeData.fakeStartTime.timeZoneOffset.inSeconds,
        );
        expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
        expect(dto.watts, 250);
      });
    });

    group('toDomain', () {
      test('converts RunningPowerRecordDto to RunningPowerRecord', () {
        final dto = RunningPowerRecordDto(
          id: FakeData.fakeId,
          time: FakeData.fakeStartTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: 0,
          metadata: MetadataDto(
            dataOrigin: FakeData.fakeDataOrigin,
            recordingMethod: RecordingMethodDto.manualEntry,
            clientRecordVersion: 1,
            deviceType: DeviceTypeDto.phone,
          ),
          watts: 300,
        );

        final record = dto.toDomain();

        expect(record.id.value, FakeData.fakeId);
        expect(record.time, FakeData.fakeStartTime);
        expect(
          record.metadata.dataOrigin?.packageName,
          FakeData.fakeDataOrigin,
        );
        expect(record.power.inWatts, 300);
      });

      test(
        'converts RunningPowerRecordDto with null id to domain with none id',
        () {
          final dto = RunningPowerRecordDto(
            time: FakeData.fakeStartTime.millisecondsSinceEpoch,
            zoneOffsetSeconds: 0,
            metadata: MetadataDto(
              dataOrigin: FakeData.fakeDataOrigin,
              recordingMethod: RecordingMethodDto.activelyRecorded,
              clientRecordVersion: 1,
              deviceType: DeviceTypeDto.watch,
            ),
            watts: 200,
          );

          final record = dto.toDomain();

          expect(record.id, HealthRecordId.none);
        },
      );
    });
  });
}
