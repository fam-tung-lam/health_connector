part of '../../health_record.dart';

/// Represents the intensity of menstrual flow.
///
/// This enum is shared by both [MenstrualFlowInstantRecord] (Android) and
/// [MenstrualFlowRecord] (iOS) to classify the flow intensity.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Maps to `MenstruationFlowRecord.FLOW_*`  constants
/// - **iOS HealthKit**: Maps to `HKCategoryValueMenstrualFlow` (iOS ≤17) or  `HKCategoryValueVaginalBleeding` (iOS ≥18) enum values
///
/// {@category Health Records}
@sinceV2_2_0
enum MenstrualFlow {
  /// Flow intensity is unknown or unspecified.
  unknown,

  /// Light menstrual flow.
  light,

  /// Medium menstrual flow.
  medium,

  /// Heavy menstrual flow.
  heavy,
}
