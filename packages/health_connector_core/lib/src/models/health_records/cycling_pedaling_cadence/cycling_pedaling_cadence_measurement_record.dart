part of '../health_record.dart';

/// Represents a single cycling pedaling cadence measurement.
///
/// Each cycling pedaling cadence measurement record represents one RPM
/// measurement at a specific time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
///   (Use [CyclingPedalingCadenceSeriesRecord])
/// - **iOS HealthKit**:
///   [`HKQuantityTypeIdentifier.cyclingCadence`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/cyclingcadence)
///
/// ## Example
///
/// ```dart
/// final record = CyclingPedalingCadenceMeasurementRecord(
///   id: HealthRecordId('ABC-123'),
///   time: DateTime.now(),
///   measurement: CyclingPedalingCadenceMeasurement(
///     time: DateTime.now(),
///     revolutionsPerMinute: Number(85),
///   ),
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [CyclingPedalingCadenceMeasurementRecordDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnAppleHealth
@immutable
final class CyclingPedalingCadenceMeasurementRecord
    extends InstantHealthRecord {
  /// Creates a cycling pedaling cadence measurement record.
  factory CyclingPedalingCadenceMeasurementRecord({
    required HealthRecordId id,
    required Metadata metadata,
    required CyclingPedalingCadenceMeasurement measurement,
    int? zoneOffsetSeconds,
  }) {
    return CyclingPedalingCadenceMeasurementRecord._(
      id: id,
      metadata: metadata,
      time: measurement.time,
      measurement: measurement,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const CyclingPedalingCadenceMeasurementRecord._({
    required super.id,
    required super.metadata,
    required super.time,
    required this.measurement,
    super.zoneOffsetSeconds,
  });

  /// The cycling pedaling cadence measurement.
  final CyclingPedalingCadenceMeasurement measurement;

  /// The time when this measurement was taken.
  ///
  /// Convenience getter that returns the time from the measurement.
  @override
  DateTime get time => measurement.time;

  /// The cycling cadence value in revolutions per minute (RPM).
  ///
  /// Convenience getter that returns the RPM from the measurement.
  Number get cadence => measurement.cadence;

  /// Creates a copy with the given fields replaced with the new values.
  CyclingPedalingCadenceMeasurementRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    CyclingPedalingCadenceMeasurement? measurement,
    int? zoneOffsetSeconds,
  }) {
    return CyclingPedalingCadenceMeasurementRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      measurement: measurement ?? this.measurement,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CyclingPedalingCadenceMeasurementRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          measurement == other.measurement;

  @override
  int get hashCode => id.hashCode ^ metadata.hashCode ^ measurement.hashCode;
}
