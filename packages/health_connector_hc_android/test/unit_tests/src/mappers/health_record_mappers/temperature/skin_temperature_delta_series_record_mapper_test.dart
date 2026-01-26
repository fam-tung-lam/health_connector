import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/temperature/skin_temperature_delta_series_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'SkinTemperatureDeltaSeriesRecordMapper',
    () {
      group(
        'SkinTemperatureDeltaSeriesRecordToDto',
        () {
          test(
            'converts SkinTemperatureDeltaSeriesRecord to '
            'SkinTemperatureDeltaSeriesRecordDto',
            () {
              final samples = [
                SkinTemperatureDeltaSample(
                  time: FakeData.fakeStartTime,
                  temperatureDelta: const Temperature.celsius(0.2),
                ),
                SkinTemperatureDeltaSample(
                  time: FakeData.fakeStartTime.add(const Duration(minutes: 5)),
                  temperatureDelta: const Temperature.celsius(-0.1),
                ),
              ];

              final record = SkinTemperatureDeltaSeriesRecord.internal(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                samples: samples,
                baseline: const Temperature.celsius(36.5),
                measurementLocation: SkinTemperatureMeasurementLocation.wrist,
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
              expect(
                dto.startZoneOffsetSeconds,
                FakeData.fakeStartTime.timeZoneOffset.inSeconds,
              );
              expect(
                dto.endZoneOffsetSeconds,
                FakeData.fakeEndTime.timeZoneOffset.inSeconds,
              );
              expect(dto.baselineCelsius, 36.5);
              expect(dto.samples.length, 2);
              expect(dto.samples[0].temperatureDeltaCelsius, 0.2);
              expect(dto.samples[1].temperatureDeltaCelsius, -0.1);
            },
          );

          test(
            'converts SkinTemperatureDeltaSeriesRecord with null '
            'baseline to DTO',
            () {
              final samples = [
                SkinTemperatureDeltaSample(
                  time: FakeData.fakeStartTime,
                  temperatureDelta: const Temperature.celsius(0.3),
                ),
              ];

              final record = SkinTemperatureDeltaSeriesRecord.internal(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                samples: samples,
              );

              final dto = record.toDto();

              expect(dto.baselineCelsius, isNull);
            },
          );
        },
      );

      group(
        'SkinTemperatureDeltaSeriesRecordDtoToDomain',
        () {
          test(
            'converts SkinTemperatureDeltaSeriesRecordDto to '
            'SkinTemperatureDeltaSeriesRecord',
            () {
              final dto = SkinTemperatureDeltaSeriesRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                samples: [
                  SkinTemperatureDeltaSampleDto(
                    time: FakeData.fakeStartTime.millisecondsSinceEpoch,
                    temperatureDeltaCelsius: 0.2,
                  ),
                  SkinTemperatureDeltaSampleDto(
                    time: FakeData.fakeStartTime
                        .add(const Duration(minutes: 5))
                        .millisecondsSinceEpoch,
                    temperatureDeltaCelsius: -0.1,
                  ),
                ],
                baselineCelsius: 36.5,
                measurementLocation:
                    SkinTemperatureMeasurementLocationDto.wrist,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(record.baseline?.inCelsius, 36.5);
              expect(record.samples.length, 2);
              expect(record.samples[0].temperatureDelta.inCelsius, 0.2);
              expect(record.samples[1].temperatureDelta.inCelsius, -0.1);
              expect(
                record.measurementLocation,
                SkinTemperatureMeasurementLocation.wrist,
              );
            },
          );

          test(
            'converts SkinTemperatureDeltaSeriesRecordDto with null '
            'baseline to domain',
            () {
              final dto = SkinTemperatureDeltaSeriesRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                samples: [
                  SkinTemperatureDeltaSampleDto(
                    time: FakeData.fakeStartTime.millisecondsSinceEpoch,
                    temperatureDeltaCelsius: 0.3,
                  ),
                ],
              );

              final record = dto.toDomain();

              expect(record.baseline, isNull);
              expect(
                record.measurementLocation,
                SkinTemperatureMeasurementLocation.unknown,
              );
            },
          );

          test(
            'converts SkinTemperatureDeltaSeriesRecordDto with null '
            'id to domain with none id',
            () {
              final dto = SkinTemperatureDeltaSeriesRecordDto(
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                samples: [],
                baselineCelsius: 37.0,
                measurementLocation:
                    SkinTemperatureMeasurementLocationDto.finger,
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
