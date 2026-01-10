import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/cycling_pedaling_cadence_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'CyclingPedalingCadenceRecordMapper',
    () {
      group(
        'CyclingPedalingCadenceRecordToDto',
        () {
          test(
            'converts CyclingPedalingCadenceRecord to '
            'CyclingPedalingCadenceRecordDto',
            () {
              final time = FakeData.fakeTime;

              final record = CyclingPedalingCadenceRecord(
                id: HealthRecordId(FakeData.fakeId),
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                time: time,
                cadence: Frequency.perMinute(90.0),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, time.millisecondsSinceEpoch);
              expect(dto.revolutionsPerMinute, 90.0);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'CyclingPedalingCadenceRecordDtoToDomain',
        () {
          test(
            'converts CyclingPedalingCadenceRecordDto to '
            'CyclingPedalingCadenceRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = CyclingPedalingCadenceRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                revolutionsPerMinute: 85.0,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.cadence.inPerMinute, 85.0);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts CyclingPedalingCadenceRecordDto '
            'with null id to domain with none id',
            () {
              final time = FakeData.fakeTime;

              final dto = CyclingPedalingCadenceRecordDto(
                time: time.millisecondsSinceEpoch,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                revolutionsPerMinute: 80.0,
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
