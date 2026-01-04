import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/energy_nutrient_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group('EnergyNutrientRecordMapper', () {
    test('toDto converts EnergyNutrientRecord to EnergyNutrientRecordDto', () {
      final record = EnergyNutrientRecord(
        time: FakeData.fakeTime,
        zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
        metadata: const Metadata(
          dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
          recordingMethod: RecordingMethod.manualEntry,
          clientRecordVersion: 1,
          device: Device(type: DeviceType.phone),
        ),
        value: const Energy.calories(500),
        foodName: 'Test Food',
        mealType: MealType.breakfast,
      );

      final dto = record.toDto();

      expect(dto.time, FakeData.fakeTime.millisecondsSinceEpoch);
      expect(dto.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
      expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
      expect(dto.value.value, closeTo(0.5, 0.0001)); // 500 cal = 0.5 kcal
      expect(dto.value.unit, EnergyUnitDto.kilocalories);
      expect(dto.foodName, 'Test Food');
      expect(dto.mealType, MealTypeDto.breakfast);
    });

    test(
      'toDomain converts EnergyNutrientRecordDto to EnergyNutrientRecord',
      () {
        final dto = EnergyNutrientRecordDto(
          time: FakeData.fakeTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
          metadata: MetadataDto(
            dataOrigin: FakeData.fakeDataOrigin,
            recordingMethod: RecordingMethodDto.manualEntry,
            clientRecordVersion: 1,
            deviceType: DeviceTypeDto.phone,
          ),
          value: EnergyDto(value: 500.0, unit: EnergyUnitDto.calories),
          foodName: 'Test Food',
          mealType: MealTypeDto.breakfast,
        );

        final record = dto.toDomain();

        expect(record.time, FakeData.fakeTime);
        expect(record.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
        expect(record.metadata.dataOrigin.packageName, FakeData.fakeDataOrigin);
        expect(record.value.inCalories, closeTo(500.0, 0.0001));
        expect(record.foodName, 'Test Food');
        expect(record.mealType, MealType.breakfast);
      },
    );
  });
}
