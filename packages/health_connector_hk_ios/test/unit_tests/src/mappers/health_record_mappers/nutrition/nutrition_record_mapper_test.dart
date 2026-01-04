import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/nutrition_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'NutritionRecordMapper',
    () {
      group(
        'NutritionRecordToDto',
        () {
          test(
            'converts NutritionRecord to NutritionRecordDto',
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
                mealType: MealType.lunch,
                foodName: 'Chicken Salad',
                energy: const Energy.calories(500),
                protein: const Mass.grams(30),
                totalCarbohydrate: const Mass.grams(40),
                totalFat: const Mass.grams(20),
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
              expect(dto.mealType, MealTypeDto.lunch);
              expect(dto.foodName, 'Chicken Salad');
              expect(dto.energy?.kilocalories, 0.5);
              expect(dto.protein?.kilograms, 0.03);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
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
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                mealType: MealTypeDto.dinner,
                foodName: 'Pasta',
                energy: EnergyDto(kilocalories: 600),
                protein: MassDto(kilograms: 25),
                totalCarbohydrate: MassDto(kilograms: 80),
                totalFat: MassDto(kilograms: 15),
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(record.mealType, MealType.dinner);
              expect(record.foodName, 'Pasta');
              expect(record.energy?.inKilocalories, 600);
              expect(record.protein?.inKilograms, 25);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts NutritionRecordDto with null id to domain with none id',
            () {
              final dto = NutritionRecordDto(
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: FakeData.fakeStartTimeZoneOffsetSeconds,
                endZoneOffsetSeconds: FakeData.fakeEndTimeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                mealType: MealTypeDto.snack,
                foodName: 'Apple',
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
