part of '../../health_record.dart';

/// Cervical mucus sensation types.
///
/// ## Platform Mapping
///
/// - **Android**: Full 1:1 mapping via `CervicalMucusRecord.SENSATION_*`
/// - **iOS**: No native support - uses custom metadata
///
/// ## iOS HealthKit Limitation
///
/// HealthKit's `HKCategoryTypeIdentifier.cervicalMucusQuality` only tracks
/// appearance, not sensation. All sensation values are stored using the
/// custom metadata key and handled by the SDK.
@sinceV2_1_0
enum CervicalMucusSensation {
  /// Unknown sensation.
  unknown,

  /// Light sensation.
  light,

  /// Medium sensation.
  medium,

  /// Heavy sensation.
  heavy,
}
