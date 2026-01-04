import 'package:health_connector_core/health_connector_core_internal.dart'
    show BloodGlucoseSpecimenSource, sinceV1_4_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show BloodGlucoseSpecimenSourceDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BloodGlucoseSpecimenSource] to [BloodGlucoseSpecimenSourceDto].
@sinceV1_4_0
@internal
extension BloodGlucoseSpecimenSourceToDto on BloodGlucoseSpecimenSource {
  /// Converts [BloodGlucoseSpecimenSource] to [BloodGlucoseSpecimenSourceDto].
  BloodGlucoseSpecimenSourceDto toDto() {
    switch (this) {
      case BloodGlucoseSpecimenSource.unknown:
        return BloodGlucoseSpecimenSourceDto.unknown;
      case BloodGlucoseSpecimenSource.interstitialFluid:
        return BloodGlucoseSpecimenSourceDto.interstitialFluid;
      case BloodGlucoseSpecimenSource.capillaryBlood:
        return BloodGlucoseSpecimenSourceDto.capillaryBlood;
      case BloodGlucoseSpecimenSource.plasma:
        return BloodGlucoseSpecimenSourceDto.plasma;
      case BloodGlucoseSpecimenSource.serum:
        return BloodGlucoseSpecimenSourceDto.serum;
      case BloodGlucoseSpecimenSource.tears:
        return BloodGlucoseSpecimenSourceDto.tears;
      case BloodGlucoseSpecimenSource.wholeBlood:
        return BloodGlucoseSpecimenSourceDto.wholeBlood;
    }
  }
}

/// Converts [BloodGlucoseSpecimenSourceDto] to [BloodGlucoseSpecimenSource].
@sinceV1_4_0
@internal
extension BloodGlucoseSpecimenSourceDtoToDomain
    on BloodGlucoseSpecimenSourceDto {
  BloodGlucoseSpecimenSource toDomain() {
    switch (this) {
      case BloodGlucoseSpecimenSourceDto.unknown:
        return BloodGlucoseSpecimenSource.unknown;
      case BloodGlucoseSpecimenSourceDto.interstitialFluid:
        return BloodGlucoseSpecimenSource.interstitialFluid;
      case BloodGlucoseSpecimenSourceDto.capillaryBlood:
        return BloodGlucoseSpecimenSource.capillaryBlood;
      case BloodGlucoseSpecimenSourceDto.plasma:
        return BloodGlucoseSpecimenSource.plasma;
      case BloodGlucoseSpecimenSourceDto.serum:
        return BloodGlucoseSpecimenSource.serum;
      case BloodGlucoseSpecimenSourceDto.tears:
        return BloodGlucoseSpecimenSource.tears;
      case BloodGlucoseSpecimenSourceDto.wholeBlood:
        return BloodGlucoseSpecimenSource.wholeBlood;
    }
  }
}
