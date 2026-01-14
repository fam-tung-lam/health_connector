import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/nutrition/nutrition_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'NutritionRecordMapper',
    () {
      group(
        'NutritionRecordToDto',
        () {
          test(
            'converts NutritionRecord with basic fields to DTO',
            () {
              const foodName = 'Chicken Salad';

              final record = NutritionRecord(
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
                foodName: foodName,
                mealType: MealType.lunch,
                energy: const Energy.kilocalories(350),
                protein: const Mass.grams(25),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.foodName, foodName);
              expect(dto.mealType, MealTypeDto.lunch);
              expect(dto.mealType, MealTypeDto.lunch);
              expect(dto.energyInKilocalories, 350);
              expect(dto.proteinInGrams, 25);
            },
          );
        },
      );

      group(
        'NutritionRecordDtoToDomain',
        () {
          test(
            'converts NutritionRecordDto to NutritionRecord',
            () {
              final dto = NutritionRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                healthDataType: HealthDataTypeDto.nutrition,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                foodName: 'Salmon Dinner',
                mealType: MealTypeDto.dinner,
                energyInKilocalories: 500.0,
                proteinInGrams: 40.0,
                calciumInGrams: 300.0,
              );

              final record = dto.toDomain() as NutritionRecord;

              expect(record, isA<NutritionRecord>());
              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(record.foodName, 'Salmon Dinner');
              expect(record.mealType, MealType.dinner);
              expect(record.energy?.inKilocalories, 500);
              expect(record.protein?.inGrams, 40);
              expect(record.calcium!.inGrams, 300);
            },
          );

          test(
            'converts NutritionRecordDto with null id to domain with none id',
            () {
              final dto = NutritionRecordDto(
                startTime: FakeData.fakeLocalStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeLocalEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                healthDataType: HealthDataTypeDto.nutrition,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                foodName: 'Snack',
                mealType: MealTypeDto.snack,
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
