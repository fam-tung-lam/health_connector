import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/lean_body_mass_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'LeanBodyMassRecordMapper',
    () {
      group(
        'LeanBodyMassRecordToDto',
        () {
          test(
            'converts LeanBodyMassRecord to LeanBodyMassRecordDto',
            () {
              final time = FakeData.fakeTime;

              final record = LeanBodyMassRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.phone),
                ),
                mass: const Mass.kilograms(55.0),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, time.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(dto.mass.kilograms, 55.0);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'LeanBodyMassRecordDtoToDomain',
        () {
          test(
            'converts LeanBodyMassRecordDto to LeanBodyMassRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = LeanBodyMassRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                mass: MassDto(kilograms: 58.0),
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, time);
              expect(record.mass.inKilograms, 58.0);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts LeanBodyMassRecordDto with null id to '
            'domain with none id',
            () {
              final time = FakeData.fakeTime;

              final dto = LeanBodyMassRecordDto(
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                mass: MassDto(kilograms: 52.0),
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
