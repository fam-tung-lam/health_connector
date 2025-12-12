part of 'health_record.dart';

/// Represents a menstrual cycle record (iOS HealthKit).
///
/// **Platform:** iOS only.
///
/// Maps to `HKCategoryTypeIdentifier.menstrualFlow`.
///
/// On iOS, menstrual flow data is stored as category samples.
/// This record includes the flow intensity and a flag indicating if this
/// sample marks the start of a menstrual cycle.
@sinceV1_4_0
@supportedOnAppleHealth
@immutable
final class MenstrualCycleRecord extends IntervalHealthRecord {
  /// Creates a menstrual cycle record.
  const MenstrualCycleRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.flow,
    required this.isStartOfCycle,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The intensity of the menstrual flow.
  final MenstrualFlow flow;

  /// Whether this record marks the start of a menstrual cycle.
  ///
  /// Maps to `HKMetadataKeyMenstrualCycleStart`.
  final bool isStartOfCycle;

  @override
  String get name => 'MenstrualCycle';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenstrualCycleRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          metadata == other.metadata &&
          flow == other.flow &&
          isStartOfCycle == other.isStartOfCycle;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      metadata.hashCode ^
      flow.hashCode ^
      isStartOfCycle.hashCode;

  @override
  String toString() {
    return 'MenstrualCycleRecord('
        'id: $id, '
        'startTime: $startTime, '
        'endTime: $endTime, '
        'flow: $flow, '
        'isStartOfCycle: $isStartOfCycle, '
        'metadata: $metadata'
        ')';
  }
}
