import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/vo2_max_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'Vo2MaxRecordMapper',
    () {
      group(
        'Vo2MaxRecordToDto',
        () {
          test(
            'converts Vo2MaxRecord to Vo2MaxRecordDto',
            () {
              final record = Vo2MaxRecord(
                time: FakeData.fakeTime,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: Metadata.manualEntry(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                ),
                mLPerKgPerMin: const Number(45.5),
                testType: Vo2MaxTestType.rockportFitnessTest,
              );

              final dto = record.toDto();

              expect(dto.id, isNull);
              expect(dto.time, FakeData.fakeTime.millisecondsSinceEpoch);
              expect(
                dto.zoneOffsetSeconds,
                FakeData.fakeTime.timeZoneOffset.inSeconds,
              );
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.mLPerKgPerMin.value, 45.5);
              expect(
                dto.measurementMethod,
                Vo2MaxMeasurementMethodDto.rockportFitnessTest,
              );
            },
          );
        },
      );

      group(
        'Vo2MaxRecordDtoToDomain',
        () {
          test(
            'converts Vo2MaxRecordDto to Vo2MaxRecord',
            () {
              final dto = Vo2MaxRecordDto(
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  lastModifiedTime: FakeData.fakeTime.millisecondsSinceEpoch,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  deviceType: DeviceTypeDto.phone,
                ),
                mLPerKgPerMin: NumberDto(value: 50.0),
                measurementMethod: Vo2MaxMeasurementMethodDto.cooperTest,
              );

              final record = dto.toDomain();

              expect(record.id, HealthRecordId.none);
              expect(record.time, FakeData.fakeTime);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(record.mLPerKgPerMin.value, 50.0);
              expect(
                record.testType,
                Vo2MaxTestType.cooperTest,
              );
            },
          );

          test(
            'converts Vo2MaxRecordDto with null id to domain with none id',
            () {
              final dto = Vo2MaxRecordDto(
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                mLPerKgPerMin: NumberDto(value: 42.0),
                measurementMethod: Vo2MaxMeasurementMethodDto.other,
              );

              final record = dto.toDomain();

              expect(record.id, HealthRecordId.none);
            },
          );
        },
      );

      group(
        'Vo2MaxMeasurementMethodMapper',
        () {
          parameterizedTest(
            'Should map Vo2MaxMeasurementMethodDto to Vo2MaxTestType and back',
            [
              [
                Vo2MaxMeasurementMethodDto.metabolicCart,
                Vo2MaxTestType.metabolicCart,
              ],
              [
                Vo2MaxMeasurementMethodDto.heartRateRatio,
                Vo2MaxTestType.heartRateRatio,
              ],
              [
                Vo2MaxMeasurementMethodDto.cooperTest,
                Vo2MaxTestType.cooperTest,
              ],
              [
                Vo2MaxMeasurementMethodDto.multistageFitnessTest,
                Vo2MaxTestType.multistageFitnessTest,
              ],
              [
                Vo2MaxMeasurementMethodDto.rockportFitnessTest,
                Vo2MaxTestType.rockportFitnessTest,
              ],
            ],
            (Vo2MaxMeasurementMethodDto dtoVal, Vo2MaxTestType domainVal) {
              // Test DTO -> Domain
              final dto = Vo2MaxRecordDto(
                time: FakeData.fakeTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  lastModifiedTime: FakeData.fakeTime.millisecondsSinceEpoch,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  deviceType: DeviceTypeDto.phone,
                ),
                mLPerKgPerMin: NumberDto(value: 45.0),
                measurementMethod: dtoVal,
              );

              final domain = dto.toDomain();
              expect(domain, isA<Vo2MaxRecord>());
              expect(domain.testType, domainVal);

              // Test Domain -> DTO
              final domainRecord = Vo2MaxRecord(
                time: FakeData.fakeTime,
                zoneOffsetSeconds: 0,
                metadata: Metadata.manualEntry(
                  dataOrigin: const DataOrigin('com.example.app'),
                ),
                mLPerKgPerMin: const Number(45.0),
                testType: domainVal,
              );

              final backToDto = domainRecord.toDto();
              expect(backToDto.measurementMethod, dtoVal);
            },
          );
        },
      );
    },
  );
}
