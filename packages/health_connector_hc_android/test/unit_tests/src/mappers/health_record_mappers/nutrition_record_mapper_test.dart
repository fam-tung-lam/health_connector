import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/nutrition_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

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
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.phone),
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
              expect(dto.energy?.value, 350);
              expect(dto.protein?.value, 0.025);
            },
          );

          test(
            'converts NutritionRecord with comprehensive nutrients to DTO',
            () {
              final record = NutritionRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.phone),
                ),
                foodName: 'Oatmeal with Berries',
                mealType: MealType.breakfast,
                energy: const Energy.kilocalories(300),
                protein: const Mass.grams(10),
                totalCarbohydrate: const Mass.grams(45),
                totalFat: const Mass.grams(8),
                saturatedFat: const Mass.grams(1.5),
                dietaryFiber: const Mass.grams(7),
                sugar: const Mass.grams(12),
                calcium: const Mass.grams(0.3),
                iron: const Mass.grams(0.01),
                potassium: const Mass.grams(0.5),
                zinc: const Mass.grams(0.005),
                vitaminC: const Mass.grams(0.06),
                vitaminD: const Mass.grams(0.000002),
              );

              final dto = record.toDto();

              expect(dto.foodName, 'Oatmeal with Berries');
              expect(dto.mealType, MealTypeDto.breakfast);
              expect(dto.energy?.value, 300);
              expect(dto.protein?.value, 0.01);
              expect(dto.totalCarbohydrate?.value, 0.045);
              expect(dto.totalFat?.value, 0.008);
              expect(dto.saturatedFat?.value, 0.0015);
              expect(dto.dietaryFiber?.value, 0.007);
              expect(dto.sugar?.value, 0.012);
              expect(dto.calcium?.value, 0.0003);
              expect(dto.iron?.value, 0.00001);
              expect(dto.vitaminC?.value, closeTo(0.00006, 0.0000001));
              expect(dto.vitaminD?.value, closeTo(0.000000002, 0.0000000001));
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
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
                healthDataType: HealthDataTypeDto.nutrition,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                foodName: 'Salmon Dinner',
                mealType: MealTypeDto.dinner,
                energy: EnergyDto(value: 500, unit: EnergyUnitDto.kilocalories),
                protein: MassDto(value: 40, unit: MassUnitDto.grams),
                calcium: MassDto(value: 300, unit: MassUnitDto.grams),
              );

              final record = dto.toDomain() as NutritionRecord;

              expect(record, isA<NutritionRecord>());
              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(
                record.metadata.dataOrigin.packageName,
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
