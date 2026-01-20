part of '../health_record.dart';

/// Represents whether protection was used during sexual activity.
///
/// This enum provides three states to capture protection usage information
/// across Android Health Connect and iOS HealthKit platforms.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Maps to
///   `SexualActivityRecord.SexualActivityProtectionUsed.*` constants
/// - **iOS HealthKit**: Maps to `HKMetadataKeySexualActivityProtectionUsed`
///   metadata key (boolean value)
///
/// ## Cross-Platform Support
///
/// - `protected` and `unprotected` are natively supported on both platforms
/// - `unknown` requires custom metadata handling on iOS and handled by the SDK
///
/// {@category Health Records}
@sinceV2_1_0
enum SexualActivityProtectionUsed {
  /// Protection was used during sexual activity.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKMetadataKeySexualActivityProtectionUsed = true`
  /// - **Android Health Connect**: `PROTECTION_USED_PROTECTED`
  protected,

  /// Protection was not used during sexual activity.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKMetadataKeySexualActivityProtectionUsed = false`
  /// - **Android Health Connect**: `PROTECTION_USED_UNPROTECTED`
  unprotected,

  /// Unknown whether protection was used.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Custom metadata key
  ///   `HCCustomMetadataKeySexualActivityProtectionUsed = "unknown"`
  /// - **Android Health Connect**: `PROTECTION_USED_UNKNOWN`
  ///
  /// **Note:** On iOS, this value requires custom metadata handling as
  /// HealthKit's native `HKMetadataKeySexualActivityProtectionUsed` only
  /// supports boolean values.
  unknown,
}
