part of 'health_record.dart';

/// Represents the varying flow levels of a menstrual cycle.
///
/// This enum is used by:
/// - [MenstruationFlowRecord] (Android)
/// - [MenstrualCycleRecord] (iOS)
@sinceV1_4_0
enum MenstrualFlow {
  /// Unknown or unspecified flow.
  unknown,

  /// Light menstrual flow.
  light,

  /// Medium menstrual flow.
  medium,

  /// Heavy menstrual flow.
  heavy,
}
