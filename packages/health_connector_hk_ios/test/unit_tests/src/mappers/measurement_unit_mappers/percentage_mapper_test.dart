import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group(
    'PercentageMapper',
    () {
      group(
        'PercentageToDto',
        () {
          test(
            'converts Percentage to PercentageDto',
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
            'converts PercentageDto to Percentage',
            () {
              final dto = PercentageDto(
                decimal: 0.8,
              );

              final percentage = dto.toDomain();

              expect(percentage.asWhole, 80.0);
            },
          );
        },
      );
    },
  );
}
