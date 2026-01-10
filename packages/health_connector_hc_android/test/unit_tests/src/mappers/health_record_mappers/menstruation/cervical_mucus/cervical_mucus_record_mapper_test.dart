import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/menstruation/cervical_mucus/cervical_mucus_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

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
              final record = CervicalMucusRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: FakeData.fakeTime,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                appearance: CervicalMucusAppearance.eggWhite,
                sensation: CervicalMucusSensation.medium,
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, FakeData.fakeTime.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.appearance, CervicalMucusAppearanceDto.eggWhite);
              expect(dto.sensation, CervicalMucusSensationDto.medium);
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
              final dto = CervicalMucusRecordDto(
                id: FakeData.fakeId,
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                appearance: CervicalMucusAppearanceDto.watery,
                sensation: CervicalMucusSensationDto.heavy,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, FakeData.fakeTime);
              expect(
                record.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(record.appearance, CervicalMucusAppearance.watery);
              expect(record.sensation, CervicalMucusSensation.heavy);
            },
          );

          test(
            'converts CervicalMucusRecordDto with null id to '
            'domain with none id',
            () {
              final dto = CervicalMucusRecordDto(
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                appearance: CervicalMucusAppearanceDto.unknown,
                sensation: CervicalMucusSensationDto.unknown,
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
