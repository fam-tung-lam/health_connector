import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_zinc_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group('DietaryZincRecordMapper', () {
    test('toDto converts DietaryZincRecord to DietaryZincRecordDto', () {
      final record = DietaryZincRecord(
        time: FakeData.fakeTime,
        zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
        metadata: Metadata.internal(
          dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
          recordingMethod: RecordingMethod.manualEntry,
          clientRecordVersion: 1,
          device: const Device(type: DeviceType.phone),
        ),
        mass: const Mass.grams(10),
        foodName: 'Test Food',
        mealType: MealType.breakfast,
      );

      final dto = record.toDto();
      expect(dto.time, FakeData.fakeTime.millisecondsSinceEpoch);
      expect(dto.zoneOffsetSeconds, FakeData.fakeTime.timeZoneOffset.inSeconds);
      expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
      expect(dto.grams, closeTo(10, 0.1));

      expect(dto.foodName, 'Test Food');
      expect(dto.mealType, MealTypeDto.breakfast);
    });

    test('toDomain converts DietaryZincRecordDto to DietaryZincRecord', () {
      final dto = DietaryZincRecordDto(
        time: FakeData.fakeTime.millisecondsSinceEpoch,
        zoneOffsetSeconds: FakeData.fakeTime.timeZoneOffset.inSeconds,
        metadata: MetadataDto(
          dataOrigin: FakeData.fakeDataOrigin,
          recordingMethod: RecordingMethodDto.manualEntry,
          clientRecordVersion: 1,
          deviceType: DeviceTypeDto.phone,
        ),
        grams: 10,
        foodName: 'Test Food',
        mealType: MealTypeDto.breakfast,
      );

      final record = dto.toDomain();
      expect(record.time, FakeData.fakeTime);
      expect(
        record.zoneOffsetSeconds,
        FakeData.fakeTime.timeZoneOffset.inSeconds,
      );
      expect(record.metadata.dataOrigin?.packageName, FakeData.fakeDataOrigin);
      expect(record.mass.inGrams, closeTo(10, 0.1));
      expect(record.foodName, 'Test Food');
      expect(record.mealType, MealType.breakfast);
    });
  });
}
