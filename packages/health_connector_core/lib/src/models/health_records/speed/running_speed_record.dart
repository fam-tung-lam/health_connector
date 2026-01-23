part of '../health_record.dart';

/// Represents a running speed measurement at a specific point in time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [SpeedSeriesRecord])
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.runningSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/runningspeed)
///
/// ## Example
///
/// ```dart
/// final record = RunningSpeedRecord(
///   time: DateTime.now(),
///   speed: Velocity.metersPerSecond(3.5),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealthIOS16Plus
@immutable
final class RunningSpeedRecord extends SpeedActivityRecord {
  /// Minimum valid running speed in km/h (0.0 km/h).
  ///
  /// At rest.
  /// Minimum valid running speed (0.0 km/h).
  ///
  /// At rest.
  static const Velocity minSpeed = Velocity.zero;

  /// Maximum valid running speed (50.0 km/h).
  ///
  /// World record sprint speed ~44.7 km/h (Usain Bolt); 50 km/h provides
  /// margin.
  static const Velocity maxSpeed = Velocity.kilometersPerHour(50.0);

  /// Creates a running speed record.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [speed] is outside the valid range of
  ///   [minSpeed]-[maxSpeed] km/h.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minSpeed] km/h)**: At rest.
  /// - **Maximum ([maxSpeed] km/h / 31 mph)**: World record sprint speed
  ///   ~44.7 km/h (Usain Bolt); 50 km/h provides margin.
  RunningSpeedRecord({
    required super.time,
    required super.metadata,
    required super.speed,
    super.id,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition: speed >= minSpeed && speed <= maxSpeed,
      value: speed,
      name: 'speed',
      message:
          'Running speed must be between '
          '${minSpeed.inKilometersPerHour.toStringAsFixed(1)}-'
          '${maxSpeed.inKilometersPerHour.toStringAsFixed(0)} km/h (0-31 mph). '
          'Got ${speed.inKilometersPerHour.toStringAsFixed(1)} km/h.',
    );
  }

  /// Internal factory for creating [RunningSpeedRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory RunningSpeedRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Velocity speed,
    int? zoneOffsetSeconds,
  }) {
    return RunningSpeedRecord._(
      id: id,
      time: time,
      metadata: metadata,
      speed: speed,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  RunningSpeedRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required super.speed,
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
