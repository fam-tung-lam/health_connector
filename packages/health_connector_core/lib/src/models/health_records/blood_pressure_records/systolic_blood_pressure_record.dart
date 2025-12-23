part of '../health_record.dart';

/// Represents a systolic blood pressure measurement at a specific point in
/// time.
///
/// [SystolicBloodPressureRecord] captures only the systolic (upper) blood
/// pressure value. This is useful for querying and aggregating systolic
/// values independently.
///
/// For combined blood pressure readings, see [BloodPressureRecord].
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: `HKQuantityType(.bloodPressureSystolic)`
///
/// > [!NOTE]
/// > This record type is only supported on iOS/HealthKit. It is not available
/// > on Android Health Connect, which only supports combined blood pressure
/// > readings via [BloodPressureRecord].
///
/// ## Example
///
/// ```dart
/// final record = SystolicBloodPressureRecord(
///   time: DateTime.now(),
///   pressure: Pressure.millimetersOfMercury(120),
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// {@category Health Records}
@sinceV1_2_0
@supportedOnAppleHealth
@immutable
final class SystolicBloodPressureRecord extends InstantHealthRecord {
  /// Creates a systolic blood pressure record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the blood pressure was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [pressure]: The systolic blood pressure measurement.
  const SystolicBloodPressureRecord({
    required super.time,
    required super.metadata,
    required this.pressure,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The systolic blood pressure measurement (pressure during heartbeat).
  ///
  /// Systolic is the "upper" number in a blood pressure reading.
  /// Normal values are typically around 120 mmHg.
  final Pressure pressure;

  /// Creates a copy with the given fields replaced with the new values.
  SystolicBloodPressureRecord copyWith({
    DateTime? time,
    Pressure? pressure,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return SystolicBloodPressureRecord(
      time: time ?? this.time,
      pressure: pressure ?? this.pressure,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystolicBloodPressureRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          pressure == other.pressure &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      pressure.hashCode ^
      metadata.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];
}
