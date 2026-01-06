import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/energy_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'EnergyMapper',
    () {
      group(
        'EnergyToDto',
        () {
          test(
            'converts Energy to EnergyDto in kilocalories',
            () {
              const energy = Energy.kilocalories(500.0);
              final dto = energy.toDto();

              expect(dto.kilocalories, 500.0);
            },
          );

          test(
            'converts Energy from kilojoules to kilocalories',
            () {
              const energy = Energy.kilojoules(2092.0);
              final dto = energy.toDto();

              expect(dto.kilocalories, closeTo(500.0, 0.5));
            },
          );
        },
      );

      group(
        'EnergyDtoToDomain',
        () {
          test(
            'maps EnergyDto to Energy',
            () {
              final dto = EnergyDto(kilocalories: 500.0);
              final energy = dto.toDomain();

              expect(energy.inKilocalories, 500.0);
            },
          );
        },
      );
    },
  );
}
