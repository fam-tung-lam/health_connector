import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/blood_glucose_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'BloodGlucoseMapper',
    () {
      group(
        'BloodGlucoseToDto',
        () {
          test(
            'converts BloodGlucose to BloodGlucoseDto in millimolesPerLiter',
            () {
              const bloodGlucose = BloodGlucose.millimolesPerLiter(5.5);
              final dto = bloodGlucose.toDto();

              expect(dto.value, 5.5);
              expect(dto.unit, BloodGlucoseUnitDto.millimolesPerLiter);
            },
          );

          test(
            'converts BloodGlucose from milligramsPerDeciliter to '
            'millimolesPerLiter',
            () {
              const bloodGlucose = BloodGlucose.milligramsPerDeciliter(100.0);
              final dto = bloodGlucose.toDto();

              expect(dto.unit, BloodGlucoseUnitDto.millimolesPerLiter);
              expect(dto.value, closeTo(5.55, 0.01));
            },
          );
        },
      );

      group(
        'BloodGlucoseDtoToDomain',
        () {
          parameterizedTest(
            'maps BloodGlucoseDto to BloodGlucose',
            [
              [BloodGlucoseUnitDto.millimolesPerLiter, 5.5],
              [BloodGlucoseUnitDto.milligramsPerDeciliter, 100.0],
            ],
            (BloodGlucoseUnitDto unit, double value) {
              final dto = BloodGlucoseDto(value: value, unit: unit);
              final bloodGlucose = dto.toDomain();

              switch (unit) {
                case BloodGlucoseUnitDto.millimolesPerLiter:
                  expect(bloodGlucose.inMillimolesPerLiter, value);
                case BloodGlucoseUnitDto.milligramsPerDeciliter:
                  expect(bloodGlucose.inMilligramsPerDeciliter, value);
              }
            },
          );
        },
      );
    },
  );
}
