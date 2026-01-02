import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/velocity_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
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
              const velocity = Velocity.metersPerSecond(10.0);
              final dto = velocity.toDto();

              expect(dto.value, 10.0);
              expect(dto.unit, VelocityUnitDto.metersPerSecond);
            },
          );

          test(
            'converts Velocity from kilometersPerHour to metersPerSecond',
            () {
              const velocity = Velocity.kilometersPerHour(36.0);
              final dto = velocity.toDto();

              expect(dto.unit, VelocityUnitDto.metersPerSecond);
              expect(dto.value, 10.0);
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
              [VelocityUnitDto.metersPerSecond, 10.0],
              [VelocityUnitDto.kilometersPerHour, 36.0],
              [VelocityUnitDto.milesPerHour, 22.369],
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
                  expect(velocity.inMilesPerHour, value);
              }
            },
          );
        },
      );
    },
  );
}
