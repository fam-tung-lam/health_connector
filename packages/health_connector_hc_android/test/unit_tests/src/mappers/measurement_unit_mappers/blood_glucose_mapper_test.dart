import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/blood_glucose_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

import 'package:test/test.dart';

void main() {
  group(
    'BloodGlucoseMapper',
    () {
      group(
        'BloodGlucoseToDto',
        () {
          test(
            'converts BloodGlucose to BloodGlucoseDto in millimolesPerLiter',
            () {
              const bloodGlucose = BloodGlucose.millimolesPerLiter(5.5);
              final dto = bloodGlucose.toDto();

              expect(dto.millimolesPerLiter, 5.5);
            },
          );

          test(
            'converts BloodGlucose from milligramsPerDeciliter to '
            'millimolesPerLiter',
            () {
              const bloodGlucose = BloodGlucose.milligramsPerDeciliter(100.0);
              final dto = bloodGlucose.toDto();

              expect(dto.millimolesPerLiter, closeTo(5.55, 0.01));
            },
          );
        },
      );

      group(
        'BloodGlucoseDtoToDomain',
        () {
          test(
            'maps BloodGlucoseDto to BloodGlucose',
            () {
              final dto = BloodGlucoseDto(millimolesPerLiter: 5.5);
              final bloodGlucose = dto.toDomain();

              expect(bloodGlucose.inMillimolesPerLiter, 5.5);
            },
          );
        },
      );
    },
  );
}
