part of '../health_record.dart';

/// Represents a running speed measurement at a specific point in time.
///
/// ## Platform Mapping
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.runningSpeed`
///
/// ## Example
/// ```dart
/// final record = RunningSpeedRecord(
///   time: DateTime.now(),
///   speed: Velocity.metersPerSecond(3.5),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class RunningSpeedRecord extends SpeedActivityRecord {
  /// Creates a running speed record.
  const RunningSpeedRecord({
    required super.time,
    required super.metadata,
    required super.speed,
    super.id,
    super.zoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  RunningSpeedRecord copyWith({
    DateTime? time,
    Velocity? speed,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return RunningSpeedRecord(
      time: time ?? this.time,
      speed: speed ?? this.speed,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RunningSpeedRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          speed == other.speed &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      speed.hashCode ^
      metadata.hashCode;
}
