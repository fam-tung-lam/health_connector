import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'HealthRecordMapper',
    () {
      group(
        'HealthRecordToDto',
        () {
          test(
            'converts ActiveEnergyBurnedRecord to '
            'ActiveEnergyBurnedRecordDto',
            () {
              // Given
              final HealthRecord record = ActiveEnergyBurnedRecord(
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
                energy: const Energy.kilocalories(350.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto, isA<ActiveEnergyBurnedRecordDto>());
              final caloriesDto = dto as ActiveEnergyBurnedRecordDto;
              expect(caloriesDto.id, FakeData.fakeId);
              expect(caloriesDto.energy.kilocalories, 350.0);
            },
          );

          test(
            'converts StepsRecord to StepsRecordDto',
            () {
              // Given
              final HealthRecord record = StepsRecord(
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
                  device: const Device(type: DeviceType.phone),
                ),
                count: const Number(5000),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto, isA<StepsRecordDto>());
              final stepsDto = dto as StepsRecordDto;
              expect(stepsDto.id, FakeData.fakeId);
              expect(stepsDto.count.value, 5000);
            },
          );

          test(
            'converts WeightRecord to WeightRecordDto',
            () {
              // Given
              final time = FakeData.fakeTime;

              final HealthRecord record = WeightRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                weight: const Mass.kilograms(70.5),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto, isA<WeightRecordDto>());
              final weightDto = dto as WeightRecordDto;
              expect(weightDto.id, FakeData.fakeId);
              expect(weightDto.weight.kilograms, 70.5);
            },
          );

          test(
            'converts BloodPressureRecord to BloodPressureRecordDto',
            () {
              // Given
              final time = FakeData.fakeTime;

              final HealthRecord record = BloodPressureRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: time,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                systolic: const Pressure.millimetersOfMercury(120.0),
                diastolic: const Pressure.millimetersOfMercury(80.0),
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto, isA<BloodPressureRecordDto>());
              final bpDto = dto as BloodPressureRecordDto;
              expect(bpDto.id, FakeData.fakeId);
              expect(bpDto.systolic.millimetersOfMercury, 120.0);
              expect(bpDto.diastolic.millimetersOfMercury, 80.0);
            },
          );

          test(
            'throws UnsupportedError for HeartRateSeriesRecord',
            () {
              // Given
              final HealthRecord record = HeartRateSeriesRecord(
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
                samples: const [],
              );

              // When / Then
              expect(
                record.toDto,
                throwsA(
                  isA<UnsupportedError>().having(
                    (e) => e.message,
                    'message',
                    contains('HeartRateSeriesRecord'),
                  ),
                ),
              );
            },
          );

          test(
            'throws UnsupportedError for SleepSessionRecord',
            () {
              // Given
              final HealthRecord record = SleepSessionRecord(
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
                samples: const [],
              );

              // When / Then
              expect(
                record.toDto,
                throwsA(
                  isA<UnsupportedError>().having(
                    (e) => e.message,
                    'message',
                    contains('SleepSessionRecord'),
                  ),
                ),
              );
            },
          );

          test(
            'throws UnsupportedError for TotalEnergyBurnedRecord',
            () {
              // Given
              final HealthRecord record = TotalEnergyBurnedRecord(
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
                energy: const Energy.kilocalories(500.0),
              );

              // When / Then
              expect(
                record.toDto,
                throwsA(
                  isA<UnsupportedError>().having(
                    (e) => e.message,
                    'message',
                    contains('TotalEnergyBurnedRecord'),
                  ),
                ),
              );
            },
          );
        },
      );

      group(
        'HealthRecordDtoToDomain',
        () {
          test(
            'converts ActiveEnergyBurnedRecordDto to '
            'ActiveEnergyBurnedRecord',
            () {
              // Given
              final HealthRecordDto dto = ActiveEnergyBurnedRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                energy: EnergyDto(kilocalories: 275.0),
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<ActiveEnergyBurnedRecord>());
              final caloriesRecord = record as ActiveEnergyBurnedRecord;
              expect(caloriesRecord.id.value, FakeData.fakeId);
              expect(caloriesRecord.energy.inKilocalories, 275.0);
            },
          );

          test(
            'converts StepsRecordDto to StepsRecord',
            () {
              // Given
              final HealthRecordDto dto = StepsRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                count: NumberDto(value: 8000),
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<StepsRecord>());
              final stepsRecord = record as StepsRecord;
              expect(stepsRecord.id.value, FakeData.fakeId);
              expect(stepsRecord.count.value, 8000);
            },
          );

          test(
            'converts WeightRecordDto to WeightRecord',
            () {
              // Given
              final time = FakeData.fakeTime;

              final HealthRecordDto dto = WeightRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                weight: MassDto(kilograms: 68.2),
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<WeightRecord>());
              final weightRecord = record as WeightRecord;
              expect(weightRecord.id.value, FakeData.fakeId);
              expect(weightRecord.weight.inKilograms, 68.2);
            },
          );

          test(
            'converts NutritionRecordDto to NutritionRecord',
            () {
              // Given
              final HealthRecordDto dto = NutritionRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                mealType: MealTypeDto.lunch,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<NutritionRecord>());
              final nutritionRecord = record as NutritionRecord;
              expect(nutritionRecord.id.value, FakeData.fakeId);
              expect(nutritionRecord.mealType, MealType.lunch);
            },
          );

          test(
            'converts SpeedActivityRecordDto to SpeedActivityRecord',
            () {
              // Given
              final time = FakeData.fakeTime;

              final HealthRecordDto dto = SpeedActivityRecordDto(
                id: FakeData.fakeId,
                time: time.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.watch,
                ),
                speed: VelocityDto(metersPerSecond: 1.3),
                activityType: SpeedActivityTypeDto.walking,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record, isA<SpeedActivityRecord>());
              expect(record, isA<WalkingSpeedRecord>());
              final speedRecord = record as WalkingSpeedRecord;
              expect(speedRecord.id.value, FakeData.fakeId);
              expect(speedRecord.speed.inMetersPerSecond, 1.3);
            },
          );
        },
      );
    },
  );
}
