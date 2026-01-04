import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/blood_glucose/blood_glucose_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'BloodGlucoseRecordMapper',
    () {
      group(
        'BloodGlucoseRecordToDto',
        () {
          test(
            'converts BloodGlucoseRecord to BloodGlucoseRecordDto',
            () {
              // Given
              final record = BloodGlucoseRecord(
                id: HealthRecordId(FakeData.fakeId),
                time: FakeData.fakeTime,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: const Metadata(
                  dataOrigin: DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.activelyRecorded,
                  clientRecordVersion: 1,
                  device: Device(type: DeviceType.phone),
                ),
                bloodGlucose: const BloodGlucose.millimolesPerLiter(5.5),
                relationToMeal: BloodGlucoseRelationToMeal.fasting,
                specimenSource: BloodGlucoseSpecimenSource.capillaryBlood,
                mealType: BloodGlucoseMealType.breakfast,
              );

              // When
              final dto = record.toDto();

              // Then
              expect(dto.id, FakeData.fakeId);
              expect(dto.time, FakeData.fakeTime.millisecondsSinceEpoch);
              expect(dto.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
              expect(dto.bloodGlucose.value, 5.5);
              expect(
                dto.bloodGlucose.unit,
                BloodGlucoseUnitDto.millimolesPerLiter,
              );
              expect(
                dto.relationToMeal,
                BloodGlucoseRelationToMealDto.fasting,
              );
              expect(
                dto.specimenSource,
                BloodGlucoseSpecimenSourceDto.capillaryBlood,
              );
              expect(dto.mealType, MealTypeDto.breakfast);
            },
          );
        },
      );

      group(
        'BloodGlucoseRecordDtoToDomain',
        () {
          test(
            'converts BloodGlucoseRecordDto to BloodGlucoseRecord',
            () {
              // Given
              final dto = BloodGlucoseRecordDto(
                id: FakeData.fakeId,
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: FakeData.fakeZoneOffsetSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                bloodGlucose: BloodGlucoseDto(
                  value: 110.0,
                  unit: BloodGlucoseUnitDto.milligramsPerDeciliter,
                ),
                relationToMeal: BloodGlucoseRelationToMealDto.afterMeal,
                specimenSource: BloodGlucoseSpecimenSourceDto.plasma,
                mealType: MealTypeDto.lunch,
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.id.value, FakeData.fakeId);
              expect(record.time, FakeData.fakeTime);
              expect(record.zoneOffsetSeconds, FakeData.fakeZoneOffsetSeconds);
              expect(
                record.metadata.dataOrigin.packageName,
                FakeData.fakeDataOrigin,
              );
              expect(record.bloodGlucose.inMilligramsPerDeciliter, 110.0);
              expect(
                record.relationToMeal,
                BloodGlucoseRelationToMeal.afterMeal,
              );
              expect(
                record.specimenSource,
                BloodGlucoseSpecimenSource.plasma,
              );
              expect(record.mealType, BloodGlucoseMealType.lunch);
            },
          );

          test(
            'converts BloodGlucoseRecordDto with null id to '
            'domain with none id',
            () {
              // Given
              final dto = BloodGlucoseRecordDto(
                time: FakeData.fakeLocalTime.millisecondsSinceEpoch,
                zoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                bloodGlucose: BloodGlucoseDto(
                  value: 100.0,
                  unit: BloodGlucoseUnitDto.milligramsPerDeciliter,
                ),
              );

              // When
              final record = dto.toDomain();

              // Then
              expect(record.id, HealthRecordId.none);
              expect(
                record.relationToMeal,
                BloodGlucoseRelationToMeal.unknown,
              );
              expect(
                record.specimenSource,
                BloodGlucoseSpecimenSource.unknown,
              );
              expect(record.mealType, BloodGlucoseMealType.unknown);
            },
          );
        },
      );
    },
  );
}
