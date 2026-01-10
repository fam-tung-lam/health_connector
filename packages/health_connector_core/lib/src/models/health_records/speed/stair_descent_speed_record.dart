part of '../health_record.dart';

/// Represents a stair descent speed measurement at a specific point in time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [SpeedSeriesRecord])
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.stairDescentSpeed`](https://
/// developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stairde
/// scentspeed)
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
@supportedOnAppleHealth
@immutable
final class StairDescentSpeedRecord extends SpeedActivityRecord {
  /// Creates a stair descent speed record.
  const StairDescentSpeedRecord({
    required super.time,
    required super.metadata,
    required super.speed,
    super.id,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [StairDescentSpeedRecord] instances
  /// without validation.
  ///
  /// Creates a [StairDescentSpeedRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [StairDescentSpeedRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
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

  const StairDescentSpeedRecord._({
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
