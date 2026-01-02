import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/length_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'LengthMapper',
    () {
      group(
        'LengthToDto',
        () {
          test(
            'converts Length to LengthDto in meters',
            () {
              const length = Length.meters(1.75);
              final dto = length.toDto();

              expect(dto.value, 1.75);
              expect(dto.unit, LengthUnitDto.meters);
            },
          );

          test(
            'converts Length from centimeters to meters',
            () {
              const length = Length.centimeters(175.0);
              final dto = length.toDto();

              expect(dto.unit, LengthUnitDto.meters);
              expect(dto.value, 1.75);
            },
          );
        },
      );

      group(
        'LengthDtoToDomain',
        () {
          parameterizedTest(
            'maps LengthDto to Length',
            [
              [LengthUnitDto.meters, 1.75],
              [LengthUnitDto.kilometers, 0.00175],
              [LengthUnitDto.miles, 0.001087],
              [LengthUnitDto.inches, 68.9],
              [LengthUnitDto.feet, 5.74],
            ],
            (LengthUnitDto unit, double value) {
              final dto = LengthDto(value: value, unit: unit);
              final length = dto.toDomain();

              switch (unit) {
                case LengthUnitDto.meters:
                  expect(length.inMeters, value);
                case LengthUnitDto.kilometers:
                  expect(length.inKilometers, value);
                case LengthUnitDto.miles:
                  expect(length.inMiles, closeTo(value, 0.001));
                case LengthUnitDto.inches:
                  expect(length.inInches, closeTo(value, 0.1));
                case LengthUnitDto.feet:
                  expect(length.inFeet, closeTo(value, 0.01));
              }
            },
          );
        },
      );
    },
  );
}
