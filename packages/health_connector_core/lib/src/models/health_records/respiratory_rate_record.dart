part of 'health_record.dart';

/// Represents a respiratory rate measurement at a specific point in time.
///
/// [RespiratoryRateRecord] captures the number of breaths taken per minute.
/// Respiratory rate is a vital sign that indicates respiratory function and
/// overall health status. This is a point-in-time record with a single
/// timestamp.
///
/// ## Platform Mapping
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`RespiratoryRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RespiratoryRateRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.respiratoryRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/respiratoryrate)
///
/// ## Example
///
/// ```dart
/// final record = RespiratoryRateRecord(
///   time: DateTime.now(),
///   breathsPerMin: Number(16),
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [RespiratoryRateHealthDataType]
///
/// {@category Health Records}
@sinceV1_3_0
@immutable
final class RespiratoryRateRecord extends InstantHealthRecord {
  /// Creates a respiratory rate record.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when the respiratory rate was measured.
  /// - [breathsPerMin]: The number of breaths per minute.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  const RespiratoryRateRecord({
    required super.time,
    required this.breathsPerMin,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The number of breaths per minute.
  final Number breathsPerMin;

  /// Creates a copy with the given fields replaced with the new values.
  RespiratoryRateRecord copyWith({
    DateTime? time,
    Number? breathsPerMin,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return RespiratoryRateRecord(
      time: time ?? this.time,
      breathsPerMin: breathsPerMin ?? this.breathsPerMin,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespiratoryRateRecord &&
          super == other &&
          breathsPerMin == other.breathsPerMin;

  @override
  int get hashCode => Object.hash(super.hashCode, breathsPerMin);
}
