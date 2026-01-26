import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/temperature/skin_temperature_measurement_location_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'SkinTemperatureMeasurementLocationMapper',
    () {
      parameterizedTest(
        'converts SkinTemperatureMeasurementLocation to/from DTO',
        [
          [
            SkinTemperatureMeasurementLocation.unknown,
            SkinTemperatureMeasurementLocationDto.unknown,
          ],
          [
            SkinTemperatureMeasurementLocation.finger,
            SkinTemperatureMeasurementLocationDto.finger,
          ],
          [
            SkinTemperatureMeasurementLocation.toe,
            SkinTemperatureMeasurementLocationDto.toe,
          ],
          [
            SkinTemperatureMeasurementLocation.wrist,
            SkinTemperatureMeasurementLocationDto.wrist,
          ],
        ],
        (
          SkinTemperatureMeasurementLocation domain,
          SkinTemperatureMeasurementLocationDto dto,
        ) {
          // When
          final convertedDto = domain.toDto();
          final convertedDomain = dto.toDomain();

          // Then
          expect(convertedDto, dto);
          expect(convertedDomain, domain);
        },
      );
    },
  );
}
