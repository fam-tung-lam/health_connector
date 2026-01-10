import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/cervical_mucus/cervical_mucus_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../../utils/fake_data.dart';

void main() {
  group(
    'CervicalMucusRecordMapper',
    () {
      group(
        'CervicalMucusRecordToDto',
        () {
          test(
            'converts CervicalMucusRecord to CervicalMucusRecordDto',
            () {
              final time = FakeData.fakeTime;

              final record = CervicalMucusRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                appearance: CervicalMucusAppearance.watery,
                sensation: CervicalMucusSensation.heavy,
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, time.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(
                dto.appearance,
                CervicalMucusAppearanceDto.watery,
              );
              expect(dto.sensation, CervicalMucusSensationDto.heavy);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'CervicalMucusRecordDtoToDomain',
        () {
          test(
            'converts CervicalMucusRecordDto to CervicalMucusRecord',
            () {
              final time = FakeData.fakeTime;

              final dto = CervicalMucusRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                appearance: CervicalMucusAppearanceDto.creamy,
                sensation: CervicalMucusSensationDto.medium,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, time);
              expect(record.appearance, CervicalMucusAppearance.creamy);
              expect(record.sensation, CervicalMucusSensation.medium);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts CervicalMucusRecordDto with null id to '
            'domain with none id',
            () {
              final time = FakeData.fakeTime;

              final dto = CervicalMucusRecordDto(
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                appearance: CervicalMucusAppearanceDto.dry,
                sensation: CervicalMucusSensationDto.light,
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
