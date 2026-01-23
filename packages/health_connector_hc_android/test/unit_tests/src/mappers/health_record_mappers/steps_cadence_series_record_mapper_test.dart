import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/steps_cadence_series_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  final fakeSampleTime = FakeData.fakeStartTime.add(
    const Duration(minutes: 30),
  );

  group(
    'StepsCadenceSeriesRecordMapper',
    () {
      group(
        'StepsCadenceSeriesRecordToDto',
        () {
          test(
            'converts StepsCadenceSeriesRecord to DTO',
            () {
              final record = StepsCadenceSeriesRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.watch),
                ),
                samples: [
                  StepsCadenceSample(
                    time: fakeSampleTime,
                    cadence: Frequency.perMinute(120),
                  ),
                ],
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.samples, hasLength(1));
              expect(dto.samples[0]!.stepsPerMinute, 120);
              expect(
                dto.samples[0]!.time,
                fakeSampleTime.millisecondsSinceEpoch,
              );
            },
          );
        },
      );

      group(
        'StepsCadenceSeriesRecordDtoToDomain',
        () {
          test(
            'converts DTO to StepsCadenceSeriesRecord',
            () {
              final dto = StepsCadenceSeriesRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                samples: [
                  StepsCadenceSampleDto(
                    time: fakeSampleTime.millisecondsSinceEpoch,
                    stepsPerMinute: 115,
                  ),
                ],
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(record.samples, hasLength(1));
              expect(record.samples[0].cadence.inPerMinute, 115);
              expect(record.samples[0].time, fakeSampleTime.toLocal());
            },
          );

          test(
            'converts DTO with null id to domain with none id',
            () {
              final dto = StepsCadenceSeriesRecordDto(
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                samples: [],
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
