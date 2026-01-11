part of 'health_record.dart';

/// Represents a body fat percentage measurement at a specific point in time.
///
/// [BodyFatPercentageRecord] captures the user's body fat percentage as an
/// instant measurement. Body fat percentage is expressed as a decimal value
/// between 0 and 1 (e.g., 0.25 represents 25% body fat).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BodyFatRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyFatRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.bodyFatPercentage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodyfatpercentage)
///
/// ## Example
///
/// ```dart
/// final record = BodyFatPercentageRecord(
///   id: HealthRecordId.none,
///   time: DateTime.now(),
///   percentage: Percentage.fromWhole(25), // 25% body fat
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [BodyFatPercentageDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class BodyFatPercentageRecord extends InstantHealthRecord {
  /// Creates a body fat percentage record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the body fat percentage was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [percentage]: The body fat percentage measurement (as decimal 0-1).
  const BodyFatPercentageRecord({
    required super.time,
    required super.metadata,
    required this.percentage,
    super.id,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [BodyFatPercentageRecord] instances
  /// without validation.
  ///
  /// Creates a [BodyFatPercentageRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BodyFatPercentageRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory BodyFatPercentageRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Percentage percentage,
    int? zoneOffsetSeconds,
  }) {
    return BodyFatPercentageRecord._(
      id: id,
      time: time,
      metadata: metadata,
      percentage: percentage,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  const BodyFatPercentageRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.percentage,
    super.zoneOffsetSeconds,
  });

  /// The body fat percentage measurement.
  ///
  /// This value is stored as a decimal between 0 and 1, where:
  /// - 0.0 = 0% body fat
  /// - 0.25 = 25% body fat
  /// - 1.0 = 100% body fat
  final Percentage percentage;

  /// Creates a copy with the given fields replaced with the new values.
  BodyFatPercentageRecord copyWith({
    DateTime? time,
    Percentage? percentage,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return BodyFatPercentageRecord(
      time: time ?? this.time,
      percentage: percentage ?? this.percentage,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyFatPercentageRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          percentage == other.percentage &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      percentage.hashCode ^
      metadata.hashCode;
}
