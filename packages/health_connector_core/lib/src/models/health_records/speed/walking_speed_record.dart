part of '../health_record.dart';

/// Represents a walking speed measurement at a specific point in time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [SpeedSeriesRecord])
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.walkingSpeed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingspeed)
///
/// ## Example
///
/// ```dart
/// final record = WalkingSpeedRecord(
///   time: DateTime.now(),
///   speed: Velocity.metersPerSecond(1.4),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
///
/// {@category Health Records}
@sinceV2_0_0
@supportedOnAppleHealthIOS16Plus
@immutable
final class WalkingSpeedRecord extends SpeedActivityRecord {
  /// Minimum valid walking speed in km/h (0.0 km/h).
  ///
  /// At rest.
  /// Minimum valid walking speed (0.0 km/h).
  ///
  /// At rest.
  static const Velocity minSpeed = Velocity.zero;

  /// Maximum valid walking speed (12.0 km/h).
  ///
  /// Fast power walking limit; faster speeds transition to running.
  static const Velocity maxSpeed = Velocity.kilometersPerHour(12.0);

  /// Creates a walking speed record.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [speed] is outside the valid range of
  ///   [minSpeed]-[maxSpeed] km/h.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minSpeed] km/h)**: At rest.
  /// - **Maximum ([maxSpeed] km/h / 7.5 mph)**: Fast power walking limit;
  ///   faster speeds transition to running.
  WalkingSpeedRecord({
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
          'Walking speed must be between '
          '${minSpeed.inKilometersPerHour.toStringAsFixed(1)}-'
          '${maxSpeed.inKilometersPerHour.toStringAsFixed(0)} km/h (0-7.5 mph). '
          'Got ${speed.inKilometersPerHour.toStringAsFixed(1)} km/h.',
    );
  }

  /// Internal factory for creating [WalkingSpeedRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [WalkingSpeedRecord] constructor, which enforces validation.
  @internalUse
  factory WalkingSpeedRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Velocity speed,
    int? zoneOffsetSeconds,
  }) {
    return WalkingSpeedRecord._(
      id: id,
      time: time,
      metadata: metadata,
      speed: speed,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const WalkingSpeedRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required super.speed,
    super.zoneOffsetSeconds,
  });

  /// Creates a copy with the given fields replaced with the new values.
  WalkingSpeedRecord copyWith({
    DateTime? time,
    Velocity? speed,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return WalkingSpeedRecord(
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
      other is WalkingSpeedRecord &&
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
