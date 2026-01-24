part of '../health_record.dart';

/// Represents a low cardio fitness event.
///
/// {@category Health Records}
@sinceV3_6_0
@immutable
final class LowCardioFitnessEventRecord extends IntervalHealthRecord {
  /// Internal factory for creating [LowCardioFitnessEventRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory LowCardioFitnessEventRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    Number? vo2MlPerMinPerKg,
    Number? vo2MlPerMinPerKgThreshold,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return LowCardioFitnessEventRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      vo2MlPerMinPerKg: vo2MlPerMinPerKg,
      vo2MlPerMinPerKgThreshold: vo2MlPerMinPerKgThreshold,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Creates a low cardio fitness event record.
  LowCardioFitnessEventRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    this.vo2MlPerMinPerKg,
    this.vo2MlPerMinPerKgThreshold,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The VO2 max value that triggered the event.
  final Number? vo2MlPerMinPerKg;

  /// The threshold value used to determine the low cardio fitness event.
  final Number? vo2MlPerMinPerKgThreshold;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LowCardioFitnessEventRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          vo2MlPerMinPerKg == other.vo2MlPerMinPerKg &&
          vo2MlPerMinPerKgThreshold == other.vo2MlPerMinPerKgThreshold;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      vo2MlPerMinPerKg.hashCode ^
      vo2MlPerMinPerKgThreshold.hashCode;
}
