part of '../health_record.dart';

/// Represents a running power measurement at a specific point in time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported.
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.runningPower`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/runningpower)
///
/// ## Example
///
/// ```dart
/// final record = RunningPowerRecord(
///   time: DateTime.now(),
///   power: Power.watts(250.0),
///   metadata: Metadata.automaticallyRecorded(...),
/// );
/// await healthConnector.writeRecord(record);
/// ```
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
final class RunningPowerRecord extends InstantHealthRecord {
  /// Minimum valid running power (0.0 W).
  static const Power minPower = Power.zero;

  /// Maximum valid running power (4,000.0 W).
  static const Power maxPower = Power.watts(4000.0);

  /// Creates a running power record.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [power] is outside the valid range of
  ///   [minPower]-[maxPower] W.
  RunningPowerRecord({
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
          'Running power must be between '
          '${minPower.inWatts.toStringAsFixed(0)}-'
          '${maxPower.inWatts.toStringAsFixed(0)} W. '
          'Got ${power.inWatts.toStringAsFixed(0)} W.',
    );
  }

  /// Internal factory for creating [RunningPowerRecord] instances
  /// without validation.
  @internalUse
  factory RunningPowerRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Power power,
    int? zoneOffsetSeconds,
  }) {
    return RunningPowerRecord._(
      id: id,
      time: time,
      metadata: metadata,
      power: power,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const RunningPowerRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.power,
    super.zoneOffsetSeconds,
  });

  /// The power measurement value.
  final Power power;

  /// Creates a copy with the given fields replaced with the new values.
  RunningPowerRecord copyWith({
    DateTime? time,
    Power? power,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return RunningPowerRecord(
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
      other is RunningPowerRecord &&
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
