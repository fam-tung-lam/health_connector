import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/bone_mass_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'BoneMassRecordMapper',
    () {
      group(
        'BoneMassRecordToDto',
        () {
          test(
            'converts BoneMassRecord to BoneMassRecordDto',
            () {
              final record = BoneMassRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: FakeData.fakeTime,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.phone),
                ),
                mass: const Mass.kilograms(3.2),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, FakeData.fakeTime.millisecondsSinceEpoch);
              expect(dto.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.mass.kilograms, 3.2);
            },
          );
        },
      );

      group(
        'BoneMassRecordDtoToDomain',
        () {
          test(
            'converts BoneMassRecordDto to BoneMassRecord',
            () {
              final dto = BoneMassRecordDto(
                id: FakeData.fakeId,
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                mass: MassDto(kilograms: 3.5),
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, FakeData.fakeTime);
              expect(record.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(record.mass.inKilograms, 3.5);
            },
          );

          test(
            'converts BoneMassRecordDto with null id to domain with none id',
            () {
              final dto = BoneMassRecordDto(
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                mass: MassDto(kilograms: 3.0),
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
