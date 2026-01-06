import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/velocity_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

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

              expect(dto.metersPerSecond, 2.5);
            },
          );

          test(
            'converts Velocity from kilometersPerHour to metersPerSecond',
            () {
              const velocity = Velocity.kilometersPerHour(9.0);
              final dto = velocity.toDto();

              expect(dto.metersPerSecond, 2.5);
            },
          );
        },
      );

      group(
        'VelocityDtoToDomain',
        () {
          test(
            'maps VelocityDto to Velocity',
            () {
              const value = 2.5;
              final dto = VelocityDto(metersPerSecond: value);
              final velocity = dto.toDomain();

              expect(velocity.inMetersPerSecond, value);
            },
          );
        },
      );
    },
  );
}
