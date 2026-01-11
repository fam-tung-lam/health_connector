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
/// - **Android Health Connect**: [`RespiratoryRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/RespiratoryRateRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.respiratoryRate`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/respiratoryrate)
///
/// ## Example
///
/// ```dart
/// final record = RespiratoryRateRecord(
///   time: DateTime.now(),
///   rate: Frequency.perMinute(16),
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [RespiratoryRateDataType]
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
  /// - [rate]: The number of breaths per minute.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  const RespiratoryRateRecord({
    required super.time,
    required this.rate,
    required super.metadata,
    super.id,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [BloodPressureRecord] instances without
  /// validation.
  ///
  /// Creates a [BloodPressureRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BloodPressureRecord] constructor, which enforces validation and business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory RespiratoryRateRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Frequency rate,
    int? zoneOffsetSeconds,
  }) {
    return RespiratoryRateRecord._(
      id: id,
      time: time,
      metadata: metadata,
      rate: rate,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const RespiratoryRateRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.rate,
    super.zoneOffsetSeconds,
  });

  /// The number of breaths per minute.
  final Frequency rate;

  /// Creates a copy with the given fields replaced with the new values.
  RespiratoryRateRecord copyWith({
    DateTime? time,
    Frequency? rate,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return RespiratoryRateRecord(
      time: time ?? this.time,
      rate: rate ?? this.rate,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespiratoryRateRecord && super == other && rate == other.rate;

  @override
  int get hashCode => Object.hash(super.hashCode, rate);
}
