import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/temperature/basal_body_temperature_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'BasalBodyTemperatureRecordMapper',
    () {
      group(
        'BasalBodyTemperatureRecordToDto',
        () {
          test(
            'converts BasalBodyTemperatureRecord to '
            'BasalBodyTemperatureRecordDto',
            () {
              final record = BasalBodyTemperatureRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: FakeData.fakeTime,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                temperature: const Temperature.celsius(36.5),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(dto.time, FakeData.fakeTime.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(dto.celsius, 36.5);
            },
          );
        },
      );

      group(
        'BasalBodyTemperatureRecordDtoToDomain',
        () {
          test(
            'converts BasalBodyTemperatureRecordDto to '
            'BasalBodyTemperatureRecord',
            () {
              final dto = BasalBodyTemperatureRecordDto(
                id: FakeData.fakeId,
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                measurementLocation:
                    BasalBodyTemperatureMeasurementLocationDto.wrist,
                celsius: 37.0,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.time, FakeData.fakeTime);
              expect(
                record.measurementLocation,
                BasalBodyTemperatureMeasurementLocation.wrist,
              );
              expect(record.temperature.inCelsius, 37.0);
            },
          );

          test(
            'converts BasalBodyTemperatureRecordDto with null id to '
            'domain with none id',
            () {
              final dto = BasalBodyTemperatureRecordDto(
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                measurementLocation:
                    BasalBodyTemperatureMeasurementLocationDto.wrist,
                celsius: 37.0,
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
