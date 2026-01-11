part of '../../health_record.dart';

/// Cervical mucus appearance types.
///
/// ## Platform Mapping
/// - **Android Health Connect**: Full 1:1 mapping via
///   `CervicalMucusRecord.APPEARANCE_*`
/// - **iOS HealthKit**:
///   - Natively supports: `dry`, `sticky`, `creamy`, `watery`, `eggWhite`.
///   - `unusual` and `unknown` are stored in custom metadata key.
///
/// {@category Health Records}
@sinceV2_1_0
enum CervicalMucusAppearance {
  /// Unknown appearance.
  unknown,

  /// Dry appearance.
  dry,

  /// Sticky appearance.
  sticky,

  /// Creamy appearance.
  creamy,

  /// Watery appearance.
  watery,

  /// Egg white appearance.
  eggWhite,

  /// Unusual appearance.
  unusual,
}
