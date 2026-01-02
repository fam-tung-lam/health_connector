import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/body_temperature_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

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
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
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
              expect(dto.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.temperature.value, 37.2);
              expect(dto.temperature.unit, TemperatureUnitDto.celsius);
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
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                temperature: TemperatureDto(
                  value: 98.6,
                  unit: TemperatureUnitDto.fahrenheit,
                ),
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, FakeData.fakeTime);
              expect(record.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
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
                temperature: TemperatureDto(
                  value: 36.5,
                  unit: TemperatureUnitDto.celsius,
                ),
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
