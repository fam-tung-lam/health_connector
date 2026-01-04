import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

void main() {
  group(
    'MeasurementUnitMapper',
    () {
      group(
        'MeasurementUnitToDto',
        () {
          test(
            'converts Energy to EnergyDto',
            () {
              const unit = Energy.kilocalories(500.0);
              final dto = unit.toDto();

              expect(dto, isA<EnergyDto>());
              expect(dto.kilocalories, 500.0);
            },
          );

          test(
            'converts Mass to MassDto',
            () {
              const unit = Mass.kilograms(70.0);
              final dto = unit.toDto();

              expect(dto, isA<MassDto>());
              expect(dto.kilograms, 70.0);
            },
          );

          test(
            'converts Length to LengthDto',
            () {
              const unit = Length.meters(1.75);
              final dto = unit.toDto();

              expect(dto, isA<LengthDto>());
              expect(dto.meters, 1.75);
            },
          );

          test(
            'converts Volume to VolumeDto',
            () {
              const unit = Volume.liters(2.0);
              final dto = unit.toDto();

              expect(dto, isA<VolumeDto>());
              expect(dto.liters, 2.0);
            },
          );

          test(
            'converts Number to NumberDto',
            () {
              const unit = Number(12345);
              final dto = unit.toDto();

              expect(dto, isA<NumberDto>());
              expect(dto.value, 12345);
            },
          );

          test(
            'converts Percentage to PercentageDto',
            () {
              const unit = Percentage.fromWhole(75.5);
              final dto = unit.toDto();

              expect(dto, isA<PercentageDto>());
              expect(dto.decimal, 0.755);
            },
          );
        },
      );
    },
  );
}
