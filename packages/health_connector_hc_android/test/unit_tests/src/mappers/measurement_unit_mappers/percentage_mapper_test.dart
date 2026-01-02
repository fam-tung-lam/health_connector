import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/percentage_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'PercentageMapper',
    () {
      group(
        'PercentageToDto',
        () {
          test(
            'converts Percentage to PercentageDto in decimal',
            () {
              const percentage = Percentage.fromDecimal(0.75);
              final dto = percentage.toDto();

              expect(dto.value, 0.75);
              expect(dto.unit, PercentageUnitDto.decimal);
            },
          );

          test(
            'converts Percentage from whole to decimal',
            () {
              const percentage = Percentage.fromWhole(75.0);
              final dto = percentage.toDto();

              expect(dto.unit, PercentageUnitDto.decimal);
              expect(dto.value, 0.75);
            },
          );
        },
      );

      group(
        'PercentageDtoToDomain',
        () {
          parameterizedTest(
            'maps PercentageDto to Percentage',
            [
              [PercentageUnitDto.decimal, 0.75],
              [PercentageUnitDto.whole, 75.0],
            ],
            (PercentageUnitDto unit, double value) {
              final dto = PercentageDto(value: value, unit: unit);
              final percentage = dto.toDomain();

              switch (unit) {
                case PercentageUnitDto.decimal:
                  expect(percentage.asDecimal, value);
                case PercentageUnitDto.whole:
                  expect(percentage.asWhole, value);
              }
            },
          );
        },
      );
    },
  );
}
