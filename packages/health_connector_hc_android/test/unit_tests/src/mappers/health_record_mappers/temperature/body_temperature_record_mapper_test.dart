import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/temperature/body_temperature_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'BodyTemperatureRecordMapper',
    () {
      group(
        'BodyTemperatureRecordToDto',
        () {
          test(
            'converts BodyTemperatureRecord to BodyTemperatureRecordDto',
            () {
              final record = BodyTemperatureRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: FakeData.fakeTime,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.phone),
                ),
                temperature: const Temperature.celsius(37.2),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, FakeData.fakeTime.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.temperature.celsius, 37.2);
            },
          );
        },
      );

      group(
        'BodyTemperatureRecordDtoToDomain',
        () {
          test(
            'converts BodyTemperatureRecordDto to BodyTemperatureRecord',
            () {
              final dto = BodyTemperatureRecordDto(
                id: FakeData.fakeId,
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                temperature: TemperatureDto(celsius: 37.0),
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, FakeData.fakeTime);
              expect(
                record.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(record.temperature.inFahrenheit, 98.6);
            },
          );

          test(
            'converts BodyTemperatureRecordDto with null id to '
            'domain with none id',
            () {
              final dto = BodyTemperatureRecordDto(
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                temperature: TemperatureDto(celsius: 36.5),
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
