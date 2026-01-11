part of '../health_record.dart';

/// Represents a stair ascent speed measurement at a specific point in time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [SpeedSeriesRecord])
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.stairAscentSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stairascentspeed)
///
/// ## Example
///
/// ```dart
/// final record = StairAscentSpeedRecord(
///   time: DateTime.now(),
///   speed: Velocity.metersPerSecond(0.5),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealth
@immutable
final class StairAscentSpeedRecord extends SpeedActivityRecord {
  /// Minimum valid stair ascent speed in km/h (0.0 km/h).
  ///
  /// At rest.
  /// Minimum valid stair ascent speed (0.0 km/h).
  ///
  /// At rest.
  static const Velocity minSpeed = Velocity.zero;

  /// Maximum valid stair ascent speed (2.0 km/h).
  ///
  /// Typical stair climbing 0.4-0.8 km/h; 2 km/h allows for fast stair
  /// climbing.
  static const Velocity maxSpeed = Velocity.kilometersPerHour(2.0);

  /// Creates a stair ascent speed record.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [speed] is outside the valid range of
  ///   [minSpeed]-[maxSpeed] km/h.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minSpeed] km/h)**: At rest.
  /// - **Maximum ([maxSpeed] km/h / 1.2 mph)**: Typical stair climbing
  ///   0.4-0.8 km/h; 2 km/h allows for fast stair climbing.
  StairAscentSpeedRecord({
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
          'Stair ascent speed must be between '
          '${minSpeed.inKilometersPerHour.toStringAsFixed(1)}-'
          '${maxSpeed.inKilometersPerHour.toStringAsFixed(0)} km/h (0-1.2 mph). '
          'Got ${speed.inKilometersPerHour.toStringAsFixed(2)} km/h.',
    );
  }

  /// Internal factory for creating [StairAscentSpeedRecord] instances
  /// without validation.
  ///
  /// Creates a [StairAscentSpeedRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [StairAscentSpeedRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory StairAscentSpeedRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Velocity speed,
    int? zoneOffsetSeconds,
  }) {
    return StairAscentSpeedRecord._(
      id: id,
      time: time,
      metadata: metadata,
      speed: speed,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const StairAscentSpeedRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required super.speed,
    super.zoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  StairAscentSpeedRecord copyWith({
    DateTime? time,
    Velocity? speed,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return StairAscentSpeedRecord(
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
      other is StairAscentSpeedRecord &&
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
