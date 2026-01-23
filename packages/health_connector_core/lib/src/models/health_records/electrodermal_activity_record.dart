part of 'health_record.dart';

/// Represents an electrodermal activity record over a time interval.
///
/// [ElectrodermalActivityRecord] tracks skin conductance measurements, which
/// increase as sweat gland activity increases.
///
/// ## See also
///
/// - [ElectrodermalActivityDataType]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealth
@immutable
final class ElectrodermalActivityRecord extends IntervalHealthRecord {
  /// Minimum valid conductance (0 microsiemens).
  static const Number minConductance = Number.zero;

  /// Maximum valid conductance (100 microsiemens).
  ///
  /// Typical range is 0-30 microsiemens; this provides safety margin.
  static const Number maxConductance = Number(100);

  /// Creates an electrodermal activity record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [conductance]: The skin conductance in microsiemens
  ///   (must be >= 0 and <= 100).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [conductance] is outside valid range.
  /// - [ArgumentError] if [endTime] is not after [startTime].
  ElectrodermalActivityRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.conductance,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    require(
      condition: conductance >= minConductance && conductance <= maxConductance,
      value: conductance,
      name: 'conductance',
      message:
          'Conductance must be between ${minConductance.value}-'
          '${maxConductance.value} microsiemens. '
          'Got ${conductance.value}.',
    );
  }

  /// Internal factory for creating [ElectrodermalActivityRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory ElectrodermalActivityRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Number conductance,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return ElectrodermalActivityRecord._(
      startTime: startTime,
      endTime: endTime,
      conductance: conductance,
      metadata: metadata,
      id: id,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  ElectrodermalActivityRecord._({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.conductance,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The skin conductance measurement in microsiemens.
  ///
  /// Must be between 0 and 100 microsiemens.
  final Number conductance;

  /// Creates a copy with the given fields replaced with the new values.
  ElectrodermalActivityRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Number? conductance,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return ElectrodermalActivityRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      conductance: conductance ?? this.conductance,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ElectrodermalActivityRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          conductance == other.conductance &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      conductance.hashCode ^
      metadata.hashCode;
}
