part of '../health_record.dart';

/// Represents a cycling power measurement at a specific point in time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (Use [PowerSeriesRecord])
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.cyclingPower`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/cyclingpower)
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
@supportedOnAppleHealthIOS17Plus
@immutable
final class CyclingPowerRecord extends InstantHealthRecord {
  /// Minimum valid cycling power (0.0 W).
  ///
  /// No power output (coasting).
  static const Power minPower = Power.zero;

  /// Maximum valid cycling power (3,000.0 W).
  ///
  /// Elite track sprinters can peak at ~2,500W; 3,000W provides margin for
  /// brief maximal efforts.
  static const Power maxPower = Power.watts(3000.0);

  /// Creates a cycling power record.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [power] is outside the valid range of
  /// - [ArgumentError] if [power] is outside the valid range of
  ///   [minPower]-[maxPower] W.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minPower] W)**: No power output (coasting).
  /// - **Maximum ([maxPower] W)**: Elite track sprinters can peak at
  ///   ~2,500W; 3,000W provides margin for brief maximal efforts.
  CyclingPowerRecord({
    required super.time,
    required super.metadata,
    required this.power,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition: power >= minPower && power <= maxPower,
      value: power,
      name: 'power',
      message:
          'Cycling power must be between '
          '${minPower.inWatts.toStringAsFixed(0)}-'
          '${maxPower.inWatts.toStringAsFixed(0)} W. '
          'Got ${power.inWatts.toStringAsFixed(0)} W.',
    );
  }

  /// Internal factory for creating [CyclingPowerRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
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

  CyclingPowerRecord._({
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
