part of '../health_record.dart';

/// Represents different types of contraceptive methods.
///
/// This enum provides a catalog of contraceptive types supported by iOS
/// HealthKit's contraceptive category type.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: Maps to `HKCategoryTypeIdentifier.contraceptive` values
/// - **Android Health Connect**: Not supported
///
/// ## Supported Types
///
/// All contraceptive types are iOS HealthKit only and will throw
/// [UnsupportedOperationException] on Android Health Connect.
///
/// {@category Health Records}
/// {@category Reproductive Health}
@sinceV3_1_0
@supportedOnAppleHealth
enum ContraceptiveType {
  /// Unspecified or unknown contraceptive method.
  ///
  /// Use this when the contraceptive method is not known or doesn't fit
  /// into any specific category.
  ///
  /// **Platform Mapping:**
  /// - **iOS HealthKit**: `HKCategoryValueContraceptive.unspecified`
  /// - **Android Health Connect**: Not supported
  unknown,

  /// Contraceptive implant.
  ///
  /// A small rod inserted under the skin that releases hormones to prevent
  /// pregnancy.
  ///
  /// **Platform Mapping:**
  /// - **iOS HealthKit**: `HKCategoryValueContraceptive.implant`
  /// - **Android Health Connect**: Not supported
  implant,

  /// Contraceptive injection.
  ///
  /// A hormonal injection administered periodically to prevent pregnancy.
  ///
  /// **Platform Mapping:**
  /// - **iOS HealthKit**: `HKCategoryValueContraceptive.injection`
  /// - **Android Health Connect**: Not supported
  injection,

  /// Intrauterine device (IUD).
  ///
  /// A small device inserted into the uterus to prevent pregnancy.
  ///
  /// **Platform Mapping:**
  /// - **iOS HealthKit**: `HKCategoryValueContraceptive.intrauterineDevice`
  /// - **Android Health Connect**: Not supported
  intrauterineDevice,

  /// Intravaginal ring.
  ///
  /// A flexible ring inserted into the vagina that releases hormones to
  /// prevent pregnancy.
  ///
  /// **Platform Mapping:**
  /// - **iOS HealthKit**: `HKCategoryValueContraceptive.intravaginalRing`
  /// - **Android Health Connect**: Not supported
  intravaginalRing,

  /// Oral contraceptive (birth control pill).
  ///
  /// A daily pill taken orally to prevent pregnancy.
  ///
  /// **Platform Mapping:**
  /// - **iOS HealthKit**: `HKCategoryValueContraceptive.oral`
  /// - **Android Health Connect**: Not supported
  oral,

  /// Contraceptive patch.
  ///
  /// A transdermal patch worn on the skin that releases hormones to prevent
  /// pregnancy.
  ///
  /// **Platform Mapping:**
  /// - **iOS HealthKit**: `HKCategoryValueContraceptive.patch`
  /// - **Android Health Connect**: Not supported
  patch,
}
