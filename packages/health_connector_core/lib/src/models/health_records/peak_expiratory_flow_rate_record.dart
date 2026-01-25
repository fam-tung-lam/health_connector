part of 'health_record.dart';

/// Represents a Peak Expiratory Flow Rate (PEFR) measurement.
///
/// Peak Expiratory Flow Rate is the maximum flow rate generated during a
/// forceful exhalation. These samples use volume/time units (liters per second).
///
/// ## See also
///
/// - [PeakExpiratoryFlowRateDataType]
///
/// {@category Health Records}
@sinceV3_6_0
@supportedOnAppleHealth
@immutable
final class PeakExpiratoryFlowRateRecord extends IntervalHealthRecord {
  /// Creates a peak expiratory flow rate record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start time of the measurement.
  /// - [endTime]: The end time of the measurement.
  /// - [volumePerSecond]: The peak expiratory flow rate in liters per second.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for the start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for the end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  PeakExpiratoryFlowRateRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.volumePerSecond,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }

  /// The peak expiratory flow rate in liters per second.
  ///
  /// This represents the maximum flow rate generated during a forceful
  /// exhalation.
  final Volume volumePerSecond;

  /// Creates a copy with the given fields replaced with the new values.
  PeakExpiratoryFlowRateRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    Volume? volumePerSecond,
  }) {
    return PeakExpiratoryFlowRateRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
      volumePerSecond: volumePerSecond ?? this.volumePerSecond,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeakExpiratoryFlowRateRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          volumePerSecond == other.volumePerSecond;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      volumePerSecond.hashCode;
}
