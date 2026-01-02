import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/velocity_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'VelocityMapper',
    () {
      group(
        'VelocityToDto',
        () {
          test(
            'converts Velocity to VelocityDto in metersPerSecond',
            () {
              const velocity = Velocity.metersPerSecond(2.5);
              final dto = velocity.toDto();

              expect(dto.value, 2.5);
              expect(dto.unit, VelocityUnitDto.metersPerSecond);
            },
          );

          test(
            'converts Velocity from kilometersPerHour to metersPerSecond',
            () {
              const velocity = Velocity.kilometersPerHour(9.0);
              final dto = velocity.toDto();

              expect(dto.unit, VelocityUnitDto.metersPerSecond);
              expect(dto.value, 2.5);
            },
          );
        },
      );

      group(
        'VelocityDtoToDomain',
        () {
          parameterizedTest(
            'maps VelocityDto to Velocity',
            [
              [VelocityUnitDto.metersPerSecond, 2.5],
              [VelocityUnitDto.kilometersPerHour, 9.0],
              [VelocityUnitDto.milesPerHour, 5.59],
            ],
            (VelocityUnitDto unit, double value) {
              final dto = VelocityDto(value: value, unit: unit);
              final velocity = dto.toDomain();

              switch (unit) {
                case VelocityUnitDto.metersPerSecond:
                  expect(velocity.inMetersPerSecond, value);
                case VelocityUnitDto.kilometersPerHour:
                  expect(velocity.inKilometersPerHour, value);
                case VelocityUnitDto.milesPerHour:
                  expect(velocity.inMilesPerHour, closeTo(value, 0.1));
              }
            },
          );
        },
      );
    },
  );
}
