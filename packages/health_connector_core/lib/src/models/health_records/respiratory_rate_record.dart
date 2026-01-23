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
  /// Minimum valid respiratory rate.
  ///
  /// Valid range: 0-1000 breaths/min, as enforced by Android Health Connect.
  ///
  /// ## Platform Compatibility
  ///
  /// - **Android Health Connect**: [RespiratoryRateRecord.kt](https://cs.android.com/androidx/platform/frameworks/support/+/androidx-main:health/connect/connect-client/src/main/java/androidx/health/connect/client/records/RespiratoryRateRecord.kt)
  /// - **Apple HealthKit**: No platform limits (application-defined)
  static final Frequency minRate = Frequency.perMinute(0.0);

  /// Maximum valid respiratory rate.
  ///
  /// Valid range: 0-1000 breaths/min, as enforced by Android Health Connect.
  ///
  /// ## Platform Compatibility
  ///
  /// - **Android Health Connect**: [RespiratoryRateRecord.kt](https://cs.android.com/androidx/platform/frameworks/support/+/androidx-main:health/connect/connect-client/src/main/java/androidx/health/connect/client/records/RespiratoryRateRecord.kt)
  /// - **Apple HealthKit**: No platform limits (application-defined)
  static final Frequency maxRate = Frequency.perMinute(1000.0);

  /// Creates a respiratory rate record.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when the respiratory rate was measured.
  /// - [rate]: The number of breaths per minute.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [rate] is outside the valid range of
  ///   [minRate]-[maxRate] breaths/min.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minRate])**: 0 breaths/min matches Health Connect, though
  ///   physiologically significant bradypnea begins around 4 breaths/min.
  /// - **Maximum ([maxRate])**: 1000 breaths/min ensures Health Connect
  ///   compatibility. Normal severe tachypnea is ~80 breaths/min.
  RespiratoryRateRecord({
    required super.time,
    required this.rate,
    required super.metadata,
    super.id,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition: rate >= minRate && rate <= maxRate,
      value: rate,
      name: 'rate',
      message:
          'Respiratory rate must be between '
          '${minRate.inPerMinute.toStringAsFixed(0)}-'
          '${maxRate.inPerMinute.toStringAsFixed(0)} breaths/min. '
          'Got ${rate.inPerMinute.toStringAsFixed(1)} breaths/min.',
    );
  }

  /// Internal factory for creating [BloodPressureRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BloodPressureRecord] constructor, which enforces validation and business
  /// rules.
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

  RespiratoryRateRecord._({
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
      other is RespiratoryRateRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          metadata == other.metadata &&
          rate == other.rate;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      metadata.hashCode ^
      rate.hashCode;
}
