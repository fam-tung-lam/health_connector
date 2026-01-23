part of '../health_record.dart';

/// Represents a stair descent speed measurement at a specific point in time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [SpeedSeriesRecord])
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.stairDescentSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stairdescentspeed)
///
/// ## Example
///
/// ```dart
/// final record = StairDescentSpeedRecord(
///   time: DateTime.now(),
///   speed: Velocity.metersPerSecond(0.6),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealthIOS16Plus
@immutable
final class StairDescentSpeedRecord extends SpeedActivityRecord {
  /// Minimum valid stair descent speed in km/h (0.0 km/h).
  ///
  /// At rest.
  /// Minimum valid stair descent speed (0.0 km/h).
  ///
  /// At rest.
  static const Velocity minSpeed = Velocity.zero;

  /// Maximum valid stair descent speed (3.0 km/h).
  ///
  /// Descent typically faster than ascent (~0.5-1 km/h); 3 km/h allows for fast
  /// descent.
  static const Velocity maxSpeed = Velocity.kilometersPerHour(3.0);

  /// Creates a stair descent speed record.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [speed] is outside the valid range of
  ///   [minSpeed]-[maxSpeed] km/h.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minSpeed] km/h)**: At rest.
  /// - **Maximum ([maxSpeed] km/h / 1.9 mph)**: Descent typically faster than
  ///   ascent (~0.5-1 km/h); 3 km/h allows for fast descent.
  StairDescentSpeedRecord({
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
          'Stair descent speed must be between '
          '${minSpeed.inKilometersPerHour.toStringAsFixed(1)}-'
          '${maxSpeed.inKilometersPerHour.toStringAsFixed(0)} km/h (0-1.9 mph). '
          'Got ${speed.inKilometersPerHour.toStringAsFixed(2)} km/h.',
    );
  }

  /// Internal factory for creating [StairDescentSpeedRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [StairDescentSpeedRecord] constructor, which enforces validation.
  @internalUse
  factory StairDescentSpeedRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Velocity speed,
    int? zoneOffsetSeconds,
  }) {
    return StairDescentSpeedRecord._(
      id: id,
      time: time,
      metadata: metadata,
      speed: speed,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  StairDescentSpeedRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required super.speed,
    super.zoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  StairDescentSpeedRecord copyWith({
    DateTime? time,
    Velocity? speed,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return StairDescentSpeedRecord(
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
      other is StairDescentSpeedRecord &&
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
