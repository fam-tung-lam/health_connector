import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/percentage_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

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

              expect(dto.decimal, 0.75);
            },
          );

          test(
            'converts Percentage from whole to decimal',
            () {
              const percentage = Percentage.fromWhole(75.0);
              final dto = percentage.toDto();

              expect(dto.decimal, 0.75);
            },
          );
        },
      );

      group(
        'PercentageDtoToDomain',
        () {
          test(
            'maps PercentageDto to Percentage',
            () {
              final dto = PercentageDto(decimal: 0.75);
              final percentage = dto.toDomain();

              expect(percentage.asDecimal, 0.75);
            },
          );
        },
      );
    },
  );
}
