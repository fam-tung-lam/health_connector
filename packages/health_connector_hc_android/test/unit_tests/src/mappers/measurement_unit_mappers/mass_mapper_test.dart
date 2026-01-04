import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/mass_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

import 'package:test/test.dart';

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
            'converts Mass from pounds to kilograms',
            () {
              const mass = Mass.pounds(154.324);
              final dto = mass.toDto();

              expect(dto.kilograms, closeTo(70.0, 0.1));
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
              final dto = MassDto(kilograms: 70.0);
              final mass = dto.toDomain();

              expect(mass.inKilograms, closeTo(70.0, 0.0001));
            },
          );
        },
      );
    },
  );
}
