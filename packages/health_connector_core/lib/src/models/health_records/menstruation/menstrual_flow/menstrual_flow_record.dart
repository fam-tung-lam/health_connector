part of '../../health_record.dart';

/// Represents a menstrual flow measurement over a time interval.
///
/// It captures the intensity of menstrual flow during a specific time period
/// and includes metadata about whether this sample marks the start of a
/// menstrual cycle.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported. [MenstrualFlowInstantRecord]
///   should be used instead.
/// - **iOS HealthKit**: [`HKCategoryTypeIdentifier.menstrualFlow`](https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier/menstrualflow)
///
/// ## Example
///
/// ```dart
/// // Single-sample period
/// final singlePeriod = MenstrualFlowRecord(
///   startTime: DateTime(2024, 1, 15, 8, 0),
///   endTime: DateTime(2024, 1, 18, 20, 0),
///   flow: MenstrualFlowType.medium,
///   isCycleStart: true,
///   metadata: Metadata.manualEntry(),
/// );
///
/// // Multi-sample period (first sample)
/// final firstSample = MenstrualFlowRecord(
///   startTime: DateTime(2024, 1, 15, 8, 0),
///   endTime: DateTime(2024, 1, 15, 14, 0),
///   flow: MenstrualFlowType.heavy,
///   isCycleStart: true,
///   metadata: Metadata.manualEntry(),
/// );
///
/// // Multi-sample period (subsequent sample)
/// final secondSample = MenstrualFlowRecord(
///   startTime: DateTime(2024, 1, 15, 14, 0),
///   endTime: DateTime(2024, 1, 15, 20, 0),
///   flow: MenstrualFlowType.medium,
///   isCycleStart: false,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [MenstrualFlowDataType]
/// - [MenstrualFlowInstantRecord] - Android instant-based alternative
/// - [MenstrualFlow]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnAppleHealth
@immutable
final class MenstrualFlowRecord extends IntervalHealthRecord {
  /// Creates a menstrual flow record.
  ///
  /// Records the intensity of menstrual flow during the interval from
  /// [startTime] to [endTime]. The [flow] indicates the flow intensity
  /// (unknown, light, medium, or heavy).
  ///
  /// The [isCycleStart] flag maps to iOS HealthKit's
  /// `HKMetadataKeyMenstrualCycleStart` metadata and indicates whether this
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  MenstrualFlowRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.flow,
    required this.isCycleStart,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }

  /// Internal factory for creating [MenstrualFlowRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory MenstrualFlowRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required MenstrualFlow flow,
    required bool isCycleStart,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return MenstrualFlowRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      flow: flow,
      isCycleStart: isCycleStart,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  MenstrualFlowRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.flow,
    required this.isCycleStart,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The menstrual flow intensity.
  ///
  /// Indicates the flow level during the interval.
  final MenstrualFlow flow;

  /// Whether this sample marks the start of a menstrual cycle.
  ///
  /// Maps to iOS HealthKit's `HKMetadataKeyMenstrualCycleStart` metadata.
  ///
  /// ## Usage
  /// - **Single-sample period**: Set to `true`
  /// - **Multi-sample period**:
  ///   - First sample: `true`
  ///   - Subsequent samples: `false`
  final bool isCycleStart;

  /// Creates a copy with the given fields replaced with the new values.
  MenstrualFlowRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    MenstrualFlow? flow,
    bool? isCycleStart,
  }) {
    return MenstrualFlowRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
      flow: flow ?? this.flow,
      isCycleStart: isCycleStart ?? this.isCycleStart,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenstrualFlowRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          flow == other.flow &&
          isCycleStart == other.isCycleStart;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      flow.hashCode ^
      isCycleStart.hashCode;
}
