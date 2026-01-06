import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/blood_pressure/blood_pressure_body_position_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'BloodPressureBodyPositionMapper',
    () {
      parameterizedTest(
        'converts BloodPressureBodyPosition to/from DTO',
        [
          [
            BloodPressureBodyPosition.unknown,
            BodyPositionDto.unknown,
          ],
          [
            BloodPressureBodyPosition.standingUp,
            BodyPositionDto.standingUp,
          ],
          [
            BloodPressureBodyPosition.sittingDown,
            BodyPositionDto.sittingDown,
          ],
          [
            BloodPressureBodyPosition.lyingDown,
            BodyPositionDto.lyingDown,
          ],
          [
            BloodPressureBodyPosition.reclining,
            BodyPositionDto.reclining,
          ],
        ],
        (BloodPressureBodyPosition domain, BodyPositionDto dto) {
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
