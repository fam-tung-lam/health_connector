import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group('HealthRecordMapper', () {
    group('toDto', () {
      test('should map supported records correctly', () {
        // ActiveCaloriesBurnedRecord
        final caloriesRecord = ActiveCaloriesBurnedRecord(
          startTime: DateTime(2025),
          endTime: DateTime(2025).add(const Duration(hours: 1)),
          energy: const Energy.calories(100),
          metadata: Metadata.manualEntry(),
        );
        expect(caloriesRecord.toDto(), isA<ActiveCaloriesBurnedRecordDto>());

        // StepsRecord
        final stepsRecord = StepsRecord(
          startTime: DateTime(2023, 1, 1, 10),
          endTime: DateTime(2023, 1, 1, 11),
          count: const Number(1000),
          metadata: Metadata.manualEntry(),
        );
        expect(stepsRecord.toDto(), isA<StepsRecordDto>());
      });

      test('should throw UnsupportedError for unsupported records', () {
        expect(
          () => WalkingRunningDistanceRecord(
            startTime: DateTime.now(),
            endTime: DateTime.now().add(const Duration(minutes: 10)),
            distance: const Length.meters(100),
            metadata: Metadata.manualEntry(),
          ).toDto(),
          throwsUnsupportedError,
        );

        // Unsupported types on Health Connect
        expect(
          () => BasalEnergyBurnedRecord(
            startTime: DateTime.now(),
            endTime: DateTime.now().add(const Duration(minutes: 10)),
            energy: const Energy.calories(100),
            metadata: Metadata.manualEntry(),
          ).toDto(),
          throwsUnsupportedError,
        );

        expect(
          () => VitaminANutrientRecord(
            time: DateTime.now(),
            mass: const Mass.grams(1),
            metadata: Metadata.manualEntry(),
          ).toDto(),
          throwsUnsupportedError,
        );
      });
    });

    group('toDomain', () {
      test('should map DTOs to supported records correctly', () {
        // ActiveCaloriesBurnedRecordDto
        final caloriesDto = ActiveCaloriesBurnedRecordDto(
          startTime: DateTime(2025).millisecondsSinceEpoch,
          endTime: DateTime(
            2025,
          ).add(const Duration(hours: 1)).millisecondsSinceEpoch,
          energy: EnergyDto(kilocalories: 0.1), // 100 cal = 0.1 kcal
          metadata: MetadataDto(
            dataOrigin: 'com.example',
            deviceType: DeviceTypeDto.unknown,
            recordingMethod: RecordingMethodDto.unknown,
            lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
          ),
        );
        expect(caloriesDto.toDomain(), isA<ActiveCaloriesBurnedRecord>());

        // StepsRecordDto
        final stepsDto = StepsRecordDto(
          startTime: DateTime(2023, 1, 1, 10).millisecondsSinceEpoch,
          endTime: DateTime(2023, 1, 1, 11).millisecondsSinceEpoch,
          count: NumberDto(value: 1000.0),
          metadata: MetadataDto(
            dataOrigin: 'com.example',
            deviceType: DeviceTypeDto.unknown,
            recordingMethod: RecordingMethodDto.unknown,
            lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
          ),
        );
        expect(stepsDto.toDomain(), isA<StepsRecord>());
      });
    });
  });
}
