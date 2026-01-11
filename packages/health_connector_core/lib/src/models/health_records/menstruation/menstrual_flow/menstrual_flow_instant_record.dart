part of '../../health_record.dart';

/// Represents a menstrual flow measurement at a specific point in time.
///
/// It captures the intensity of menstrual flow at a single timestamp.
///
/// ## Platform Support
///
/// - **Android Health Connect**: [`MenstruationFlowRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/MenstruationFlowRecord)
/// - **iOS HealthKit**: Not supported. Use [MenstrualFlowRecord] instead.
///
/// ## Example
///
/// ```dart
/// final record = MenstrualFlowInstantRecord(
///   time: DateTime(2024, 1, 15, 8, 30),
///   flow: MenstrualFlowType.medium,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [MenstrualFlowInstantDataType]
/// - [MenstrualFlowRecord] - iOS interval-based alternative
/// - [MenstrualFlow]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class MenstrualFlowInstantRecord extends InstantHealthRecord {
  /// Creates a menstrual flow instant record.
  ///
  /// Records the intensity of menstrual flow at a specific [time].
  /// The [flow] indicates the flow intensity.
  ///
  /// Use [metadata] to describe the data source. The timezone offset can be
  /// provided via [zoneOffsetSeconds].
  const MenstrualFlowInstantRecord({
    required super.time,
    required super.metadata,
    required this.flow,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [BloodPressureRecord] instances without
  /// validation.
  ///
  /// Creates a [BloodPressureRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BloodPressureRecord] constructor, which enforces validation and business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory MenstrualFlowInstantRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required MenstrualFlow flow,
    int? zoneOffsetSeconds,
  }) {
    return MenstrualFlowInstantRecord._(
      id: id,
      time: time,
      metadata: metadata,
      flow: flow,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const MenstrualFlowInstantRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.flow,
    super.zoneOffsetSeconds,
  });

  /// The menstrual flow intensity.
  ///
  /// Indicates the flow level at the recorded [time].
  final MenstrualFlow flow;

  /// Creates a copy with the given fields replaced with the new values.
  MenstrualFlowInstantRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? time,
    int? zoneOffsetSeconds,
    MenstrualFlow? flow,
  }) {
    return MenstrualFlowInstantRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      time: time ?? this.time,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      flow: flow ?? this.flow,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenstrualFlowInstantRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          flow == other.flow;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      time.hashCode ^
      zoneOffsetSeconds.hashCode ^
      flow.hashCode;
}
