part of '../health_record.dart';

/// Represents the source of the biological specimen used for the measurement.
///
/// {@category Health Records}
@sinceV1_4_0
enum BloodGlucoseSpecimenSource {
  /// Source unknown or unspecified.
  unknown,

  /// Interstitial fluid, typically from continuous glucose monitors (CGMs).
  interstitialFluid,

  /// Capillary blood from fingerstick testing.
  capillaryBlood,

  /// Blood plasma (laboratory reference standard).
  plasma,

  /// Blood serum.
  serum,

  /// Tears (experimental measurement source).
  tears,

  /// Whole blood.
  wholeBlood,
}
