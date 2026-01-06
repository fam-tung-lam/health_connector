import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/blood_pressure/blood_pressure_measurement_location_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'BloodPressureMeasurementLocationMapper',
    () {
      parameterizedTest(
        'converts BloodPressureMeasurementLocation to/from DTO',
        [
          [
            BloodPressureMeasurementLocation.unknown,
            MeasurementLocationDto.unknown,
          ],
          [
            BloodPressureMeasurementLocation.leftWrist,
            MeasurementLocationDto.leftWrist,
          ],
          [
            BloodPressureMeasurementLocation.rightWrist,
            MeasurementLocationDto.rightWrist,
          ],
          [
            BloodPressureMeasurementLocation.leftUpperArm,
            MeasurementLocationDto.leftUpperArm,
          ],
          [
            BloodPressureMeasurementLocation.rightUpperArm,
            MeasurementLocationDto.rightUpperArm,
          ],
        ],
        (
          BloodPressureMeasurementLocation domain,
          MeasurementLocationDto dto,
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
