import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/mass_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group(
    'MassMapper',
    () {
      group(
        'MassToDto',
        () {
          test(
            'converts Mass to MassDto in kilograms',
            () {
              const mass = Mass.kilograms(70.0);
              final dto = mass.toDto();

              expect(dto.kilograms, 70.0);
            },
          );

          test(
            'converts Mass from grams to kilograms',
            () {
              const mass = Mass.grams(70000.0);
              final dto = mass.toDto();

              expect(dto.kilograms, 70.0);
            },
          );
        },
      );

      group(
        'MassDtoToDomain',
        () {
          test(
            'maps MassDto to Mass',
            () {
              const value = 70.0;
              final dto = MassDto(kilograms: value);
              final mass = dto.toDomain();

              expect(mass.inKilograms, value);
            },
          );
        },
      );
    },
  );
}
