part of '../health_record.dart';

/// Represents a cycling power measurement at a specific point in time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [PowerSeriesRecord])
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.cyclingPower`](https://devel
/// oper.apple.com/documentation/healthkit/hkquantitytypeidentifier/cyclingpower
/// )
///
/// ## Example
///
/// ```dart
/// final record = CyclingPowerRecord(
///   time: DateTime.now(),
///   power: Power.watts(250.0),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
///
/// {@category Health Records}
@sinceV2_1_0
@supportedOnAppleHealth
@immutable
final class CyclingPowerRecord extends InstantHealthRecord {
  /// Creates a cycling power record.
  const CyclingPowerRecord({
    required super.time,
    required super.metadata,
    required this.power,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [CyclingPowerRecord] instances
  /// without validation.
  ///
  /// Creates a [CyclingPowerRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [CyclingPowerRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory CyclingPowerRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Power power,
    int? zoneOffsetSeconds,
  }) {
    return CyclingPowerRecord._(
      id: id,
      time: time,
      metadata: metadata,
      power: power,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const CyclingPowerRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.power,
    super.zoneOffsetSeconds,
  });

  /// The power measurement value.
  final Power power;

  /// Creates a copy with the given fields replaced with the new values.
  CyclingPowerRecord copyWith({
    DateTime? time,
    Power? power,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return CyclingPowerRecord(
      time: time ?? this.time,
      power: power ?? this.power,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CyclingPowerRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          power == other.power &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      power.hashCode ^
      metadata.hashCode;
}
