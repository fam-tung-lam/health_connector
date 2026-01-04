import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/blood_glucose_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

void main() {
  group(
    'BloodGlucoseMapper',
    () {
      group(
        'BloodGlucoseToDto',
        () {
          test(
            'converts BloodGlucose to BloodGlucoseDto as millimolesPerLiter',
            () {
              const bloodGlucose = BloodGlucose.millimolesPerLiter(5.5);
              final dto = bloodGlucose.toDto();

              expect(dto.millimolesPerLiter, 5.5);
            },
          );

          test(
            'converts BloodGlucose from milligramsPerDecil to '
            'millimolesPerLiter',
            () {
              const bloodGlucose = BloodGlucose.milligramsPerDeciliter(99.0);
              final dto = bloodGlucose.toDto();

              expect(dto.millimolesPerLiter, closeTo(5.5, 0.1));
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
              const value = 5.5;
              final dto = BloodGlucoseDto(millimolesPerLiter: value);
              final bloodGlucose = dto.toDomain();

              expect(bloodGlucose.inMillimolesPerLiter, value);
            },
          );
        },
      );
    },
  );
}
