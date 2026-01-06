import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/total_carbohydrate_nutrient_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group('TotalCarbohydrateNutrientRecordMapper', () {
    test(
      'toDto converts TotalCarbohydrateNutrientRecord to '
      'TotalCarbohydrateNutrientRecordDto',
      () {
        final record = TotalCarbohydrateNutrientRecord(
          time: FakeData.fakeTime,
          zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
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
        expect(
          dto.zoneOffsetSeconds,
          FakeData.fakeTime.timeZoneOffset.inSeconds,
        );
        expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
        expect(dto.value.kilograms, closeTo(0.01, 0.0001));

        expect(dto.foodName, 'Test Food');
        expect(dto.mealType, MealTypeDto.breakfast);
      },
    );

    test(
      'toDomain converts TotalCarbohydrateNutrientRecordDto to '
      'TotalCarbohydrateNutrientRecord',
      () {
        final dto = TotalCarbohydrateNutrientRecordDto(
          time: FakeData.fakeTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
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
        expect(
          record.zoneOffsetSeconds,
          FakeData.fakeTime.timeZoneOffset.inSeconds,
        );
        expect(record.metadata.dataOrigin.packageName, FakeData.fakeDataOrigin);
        expect(record.value.inKilograms, closeTo(10.0, 0.0001));
        expect(record.foodName, 'Test Food');
        expect(record.mealType, MealType.breakfast);
      },
    );
  });
}
