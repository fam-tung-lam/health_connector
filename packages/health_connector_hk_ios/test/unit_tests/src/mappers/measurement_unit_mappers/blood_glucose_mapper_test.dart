import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/blood_glucose_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
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
            'converts BloodGlucose to BloodGlucoseDto as millimolesPerLiter',
            () {
              const bloodGlucose = BloodGlucose.millimolesPerLiter(5.5);
              final dto = bloodGlucose.toDto();

              expect(dto.value, 5.5);
              expect(dto.unit, BloodGlucoseUnitDto.millimolesPerLiter);
            },
          );

          test(
            'converts BloodGlucose from milligramsPerDecil to '
            'millimolesPerLiter',
            () {
              const bloodGlucose = BloodGlucose.milligramsPerDeciliter(99.0);
              final dto = bloodGlucose.toDto();

              expect(dto.unit, BloodGlucoseUnitDto.millimolesPerLiter);
              expect(dto.value, closeTo(5.5, 0.1));
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
              [BloodGlucoseUnitDto.milligramsPerDeciliter, 99.0],
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
