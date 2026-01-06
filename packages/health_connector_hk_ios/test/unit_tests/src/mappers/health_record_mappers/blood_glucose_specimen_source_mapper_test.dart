import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_glucose/blood_glucose_specimen_source_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group('BloodGlucoseSpecimenSourceMapper', () {
    group('toDto', () {
      test('converts all values correctly', () {
        expect(
          BloodGlucoseSpecimenSource.unknown.toDto(),
          BloodGlucoseSpecimenSourceDto.unknown,
        );
        expect(
          BloodGlucoseSpecimenSource.interstitialFluid.toDto(),
          BloodGlucoseSpecimenSourceDto.interstitialFluid,
        );
        expect(
          BloodGlucoseSpecimenSource.capillaryBlood.toDto(),
          BloodGlucoseSpecimenSourceDto.capillaryBlood,
        );
        expect(
          BloodGlucoseSpecimenSource.plasma.toDto(),
          BloodGlucoseSpecimenSourceDto.plasma,
        );
        expect(
          BloodGlucoseSpecimenSource.serum.toDto(),
          BloodGlucoseSpecimenSourceDto.serum,
        );
        expect(
          BloodGlucoseSpecimenSource.tears.toDto(),
          BloodGlucoseSpecimenSourceDto.tears,
        );
        expect(
          BloodGlucoseSpecimenSource.wholeBlood.toDto(),
          BloodGlucoseSpecimenSourceDto.wholeBlood,
        );
      });
    });

    group('toDomain', () {
      test('converts all values correctly', () {
        expect(
          BloodGlucoseSpecimenSourceDto.unknown.toDomain(),
          BloodGlucoseSpecimenSource.unknown,
        );
        expect(
          BloodGlucoseSpecimenSourceDto.interstitialFluid.toDomain(),
          BloodGlucoseSpecimenSource.interstitialFluid,
        );
        expect(
          BloodGlucoseSpecimenSourceDto.capillaryBlood.toDomain(),
          BloodGlucoseSpecimenSource.capillaryBlood,
        );
        expect(
          BloodGlucoseSpecimenSourceDto.plasma.toDomain(),
          BloodGlucoseSpecimenSource.plasma,
        );
        expect(
          BloodGlucoseSpecimenSourceDto.serum.toDomain(),
          BloodGlucoseSpecimenSource.serum,
        );
        expect(
          BloodGlucoseSpecimenSourceDto.tears.toDomain(),
          BloodGlucoseSpecimenSource.tears,
        );
        expect(
          BloodGlucoseSpecimenSourceDto.wholeBlood.toDomain(),
          BloodGlucoseSpecimenSource.wholeBlood,
        );
      });
    });
  });
}
