part of 'health_record.dart';

/// Represents a complete menstrual period (Android Health Connect).
///
/// **Platform:** Android only.
///
/// A [MenstruationPeriodRecord] on Android is an interval record that
/// represents the duration of a period. It does not natively contain flow info.
///
/// However, this plugin augments the record by querying for associated
/// [MenstruationFlowRecord]s that occur within the period's time range
/// and exposing them via [samples].
@sinceV1_4_0
@supportedOnHealthConnect
@immutable
final class MenstruationPeriodRecord extends IntervalHealthRecord {
  /// Creates a menstruation period record.
  const MenstruationPeriodRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.samples,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The flow records associated with this period.
  final List<MenstruationFlowRecord> samples;

  @override
  String get name => 'MenstruationPeriod';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenstruationPeriodRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          metadata == other.metadata &&
          samples.equals(other.samples);

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      metadata.hashCode ^
      Object.hashAll(samples);

  @override
  String toString() {
    return 'MenstruationPeriodRecord('
        'id: $id, '
        'startTime: $startTime, '
        'endTime: $endTime, '
        'samples: ${samples.length} flow records, '
        'metadata: $metadata'
        ')';
  }
}

/// Represents a measurement of menstrual flow at a single point in time.
///
/// **Platform:** Android Health Connect only.
///
/// This record maps directly to Android's `MenstruationFlowRecord`.
/// It is primarily used as a sample within [MenstruationPeriodRecord],
/// but can also be accessed individually if needed.
@sinceV1_4_0
@supportedOnHealthConnect
@immutable
class MenstruationFlowRecord {
  /// Creates a menstruation flow record.
  const MenstruationFlowRecord({
    required this.id,
    required this.time,
    this.flow,
    this.metadata,
    this.zoneOffsetSeconds,
  });

  /// The unique identifier for this health record.
  ///
  /// For new records (not yet written to the platform), this should be
  /// [HealthRecordId.none].
  final HealthRecordId id;

  /// The time the flow was recorded.
  final DateTime time;

  /// The intensity of the menstrual flow.
  final MenstrualFlow? flow;

  /// Metadata about the record.
  final Metadata? metadata;

  /// Time zone offset in seconds.
  final int? zoneOffsetSeconds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenstruationFlowRecord &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          metadata == other.metadata &&
          flow == other.flow;

  @override
  int get hashCode =>
      time.hashCode ^
      zoneOffsetSeconds.hashCode ^
      metadata.hashCode ^
      flow.hashCode;

  @override
  String toString() {
    return 'MenstruationFlowRecord('
        'time: $time, '
        'flow: $flow, '
        'metadata: $metadata'
        ')';
  }
}
