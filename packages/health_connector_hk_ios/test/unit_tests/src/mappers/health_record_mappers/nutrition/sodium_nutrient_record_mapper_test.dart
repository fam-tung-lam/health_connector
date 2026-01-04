import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/sodium_nutrient_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group('SodiumNutrientRecordMapper', () {
    test('toDto converts SodiumNutrientRecord to SodiumNutrientRecordDto', () {
      final record = SodiumNutrientRecord(
        time: FakeData.fakeTime,
        zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
        metadata: const Metadata(
          dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
          recordingMethod: RecordingMethod.manualEntry,
          clientRecordVersion: 1,
          device: Device(type: DeviceType.phone),
        ),
        value: const Mass.grams(10),
        foodName: 'Test Food',
        mealType: MealType.breakfast,
      );

      final dto = record.toDto();
      expect(dto.time, FakeData.fakeTime.millisecondsSinceEpoch);
      expect(dto.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
      expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
      expect(dto.value.kilograms, closeTo(0.01, 0.0001));

      expect(dto.foodName, 'Test Food');
      expect(dto.mealType, MealTypeDto.breakfast);
    });

    test(
      'toDomain converts SodiumNutrientRecordDto to SodiumNutrientRecord',
      () {
        final dto = SodiumNutrientRecordDto(
          time: FakeData.fakeTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
          metadata: MetadataDto(
            dataOrigin: FakeData.fakeDataOrigin,
            recordingMethod: RecordingMethodDto.manualEntry,
            clientRecordVersion: 1,
            deviceType: DeviceTypeDto.phone,
          ),
          value: MassDto(kilograms: 10.0),
          foodName: 'Test Food',
          mealType: MealTypeDto.breakfast,
        );

        final record = dto.toDomain();

        expect(record.time, FakeData.fakeTime);
        expect(record.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
        expect(record.metadata.dataOrigin.packageName, FakeData.fakeDataOrigin);
        expect(record.value.inKilograms, closeTo(10.0, 0.0001));
        expect(record.foodName, 'Test Food');
        expect(record.mealType, MealType.breakfast);
      },
    );
  });
}
