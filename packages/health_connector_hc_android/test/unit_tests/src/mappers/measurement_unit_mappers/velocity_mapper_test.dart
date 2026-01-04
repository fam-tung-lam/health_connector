import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/velocity_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

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

              expect(dto.metersPerSecond, 10.0);
            },
          );

          test(
            'converts Velocity from kilometersPerHour to metersPerSecond',
            () {
              const velocity = Velocity.kilometersPerHour(36.0);
              final dto = velocity.toDto();

              expect(dto.metersPerSecond, 10.0);
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
              final dto = VelocityDto(metersPerSecond: 10.0);
              final velocity = dto.toDomain();

              expect(velocity.inMetersPerSecond, 10.0);
            },
          );
        },
      );
    },
  );
}
