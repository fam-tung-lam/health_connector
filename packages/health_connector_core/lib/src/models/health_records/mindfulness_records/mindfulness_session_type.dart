part of '../health_record.dart';

/// Type of mindfulness session.
///
/// Represents different types of mindfulness activities that can be recorded.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Maps to
///   `MindfulnessSessionRecord.MINDFULNESS_SESSION_TYPE_***`
/// - **iOS HealthKit**: Stored in custom metadata since iOS HealthKit only
///   supports generic `HKCategoryValue.notApplicable` type
///
/// > [!NOTE]
/// > **iOS HealthKit Limitation**: HealthKit only supports a single generic
/// > mindfulness category type with `HKCategoryValue.notApplicable`. The
/// > [MindfulnessSessionType] is preserved via custom metadata when writing
/// > through this SDK.
/// > When viewing in the native iOS Apple Health app, all sessions appear as
/// > generic "Mindful Minutes" without type differentiation.
///
/// {@category Health Records}
@sinceV2_1_0
enum MindfulnessSessionType {
  /// Unknown or unspecified session type.
  ///
  /// Health Connect value: `MINDFULNESS_SESSION_TYPE_UNKNOWN` (0)
  unknown,

  /// Meditation session.
  ///
  /// Focused mental practice for relaxation, awareness, or spiritual growth.
  meditation,

  /// Breathing exercise session.
  ///
  /// Controlled breathing techniques for relaxation or focus.
  breathing,

  /// Music-based mindfulness session.
  ///
  /// Mindfulness practice accompanied by music or sound therapy.
  music,

  /// Movement-based mindfulness session.
  ///
  /// Mindful movement practices such as walking meditation or gentle
  /// stretching.
  movement,

  /// Unguided mindfulness session.
  ///
  /// Self-directed mindfulness practice without external guidance.
  unguided,
}
