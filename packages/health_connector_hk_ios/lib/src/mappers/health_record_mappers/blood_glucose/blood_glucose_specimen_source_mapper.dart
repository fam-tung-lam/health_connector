import 'package:health_connector_core/health_connector_core_internal.dart'
    show BloodGlucoseSpecimenSource, sinceV1_4_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BloodGlucoseSpecimenSourceDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BloodGlucoseSpecimenSource] to [BloodGlucoseSpecimenSourceDto].
@sinceV1_4_0
@internal
extension BloodGlucoseSpecimenSourceToDto on BloodGlucoseSpecimenSource {
  /// Converts [BloodGlucoseSpecimenSource] to [BloodGlucoseSpecimenSourceDto].
  BloodGlucoseSpecimenSourceDto toDto() {
    return switch (this) {
      BloodGlucoseSpecimenSource.unknown =>
        BloodGlucoseSpecimenSourceDto.unknown,
      BloodGlucoseSpecimenSource.interstitialFluid =>
        BloodGlucoseSpecimenSourceDto.interstitialFluid,
      BloodGlucoseSpecimenSource.capillaryBlood =>
        BloodGlucoseSpecimenSourceDto.capillaryBlood,
      BloodGlucoseSpecimenSource.plasma => BloodGlucoseSpecimenSourceDto.plasma,
      BloodGlucoseSpecimenSource.serum => BloodGlucoseSpecimenSourceDto.serum,
      BloodGlucoseSpecimenSource.tears => BloodGlucoseSpecimenSourceDto.tears,
      BloodGlucoseSpecimenSource.wholeBlood =>
        BloodGlucoseSpecimenSourceDto.wholeBlood,
    };
  }
}

/// Converts [BloodGlucoseSpecimenSourceDto] to [BloodGlucoseSpecimenSource].
@sinceV1_4_0
@internal
extension BloodGlucoseSpecimenSourceDtoToDomain
    on BloodGlucoseSpecimenSourceDto {
  BloodGlucoseSpecimenSource toDomain() {
    return switch (this) {
      BloodGlucoseSpecimenSourceDto.unknown =>
        BloodGlucoseSpecimenSource.unknown,
      BloodGlucoseSpecimenSourceDto.interstitialFluid =>
        BloodGlucoseSpecimenSource.interstitialFluid,
      BloodGlucoseSpecimenSourceDto.capillaryBlood =>
        BloodGlucoseSpecimenSource.capillaryBlood,
      BloodGlucoseSpecimenSourceDto.plasma => BloodGlucoseSpecimenSource.plasma,
      BloodGlucoseSpecimenSourceDto.serum => BloodGlucoseSpecimenSource.serum,
      BloodGlucoseSpecimenSourceDto.tears => BloodGlucoseSpecimenSource.tears,
      BloodGlucoseSpecimenSourceDto.wholeBlood =>
        BloodGlucoseSpecimenSource.wholeBlood,
    };
  }
}
