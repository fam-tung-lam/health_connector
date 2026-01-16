import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/forced_vital_capacity_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'ForcedVitalCapacityRecordMapper',
    () {
      group(
        'ForcedVitalCapacityRecordToDto',
        () {
          test(
            'converts ForcedVitalCapacityRecord to '
            'ForcedVitalCapacityRecordDto',
            () {
              final record = ForcedVitalCapacityRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: FakeData.fakeStartTime,
                zoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                volume: const Volume.liters(2.5),
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
              expect(dto.liters, 2.5);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'ForcedVitalCapacityRecordDtoToDomain',
        () {
          test(
            'converts ForcedVitalCapacityRecordDto to '
            'ForcedVitalCapacityRecord',
            () {
              final dto = ForcedVitalCapacityRecordDto(
                id: FakeData.fakeId,
                time: FakeData.fakeStartTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                liters: 1.5,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, FakeData.fakeStartTime);
              expect(record.volume.inLiters, 1.5);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts ForcedVitalCapacityRecordDto with null id to '
            'domain with none id',
            () {
              final dto = ForcedVitalCapacityRecordDto(
                time: FakeData.fakeStartTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                liters: 2.0,
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
