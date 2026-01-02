import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/length_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
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
              const length = Length.meters(1000.0);
              final dto = length.toDto();

              expect(dto.value, 1000.0);
              expect(dto.unit, LengthUnitDto.meters);
            },
          );

          test(
            'converts Length from kilometers to meters',
            () {
              const length = Length.kilometers(1.0);
              final dto = length.toDto();

              expect(dto.unit, LengthUnitDto.meters);
              expect(dto.value, 1000.0);
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
              [LengthUnitDto.meters, 1000.0],
              [LengthUnitDto.kilometers, 1.0],
              [LengthUnitDto.miles, 0.621371],
              [LengthUnitDto.feet, 3280.84],
              [LengthUnitDto.inches, 39370.1],
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
                  expect(length.inMiles, value);
                case LengthUnitDto.feet:
                  expect(length.inFeet, value);
                case LengthUnitDto.inches:
                  expect(length.inInches, value);
              }
            },
          );
        },
      );
    },
  );
}
