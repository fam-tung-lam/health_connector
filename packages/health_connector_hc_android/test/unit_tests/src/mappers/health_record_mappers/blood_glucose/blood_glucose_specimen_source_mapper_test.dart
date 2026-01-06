import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/blood_glucose/blood_glucose_specimen_source_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'BloodGlucoseSpecimenSourceMapper',
    () {
      parameterizedTest(
        'converts BloodGlucoseSpecimenSource to/from DTO',
        [
          [
            BloodGlucoseSpecimenSource.unknown,
            BloodGlucoseSpecimenSourceDto.unknown,
          ],
          [
            BloodGlucoseSpecimenSource.interstitialFluid,
            BloodGlucoseSpecimenSourceDto.interstitialFluid,
          ],
          [
            BloodGlucoseSpecimenSource.capillaryBlood,
            BloodGlucoseSpecimenSourceDto.capillaryBlood,
          ],
          [
            BloodGlucoseSpecimenSource.plasma,
            BloodGlucoseSpecimenSourceDto.plasma,
          ],
          [
            BloodGlucoseSpecimenSource.serum,
            BloodGlucoseSpecimenSourceDto.serum,
          ],
          [
            BloodGlucoseSpecimenSource.tears,
            BloodGlucoseSpecimenSourceDto.tears,
          ],
          [
            BloodGlucoseSpecimenSource.wholeBlood,
            BloodGlucoseSpecimenSourceDto.wholeBlood,
          ],
        ],
        (
          BloodGlucoseSpecimenSource domain,
          BloodGlucoseSpecimenSourceDto dto,
        ) {
          // When
          final actualDto = domain.toDto();
          final actualDomain = dto.toDomain();

          // Then
          expect(actualDto, dto);
          expect(actualDomain, domain);
        },
      );
    },
  );
}
