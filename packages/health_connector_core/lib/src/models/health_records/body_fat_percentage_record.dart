part of 'health_record.dart';

/// Represents a body fat percentage measurement at a specific point in time.
///
/// [BodyFatPercentageRecord] captures the user's body fat percentage as an
/// instant measurement. Body fat percentage is expressed as a decimal value
/// between 0 and 1 (e.g., 0.25 represents 25% body fat).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `BodyFatRecord`
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.bodyFatPercentage`
///
/// ## Example
///
/// ```dart
/// final record = BodyFatPercentageRecord(
///   id: HealthRecordId.none,
///   time: DateTime.now(),
///   percentage: Percentage.fromWhole(25), // 25% body fat
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
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
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [percentage] is negative.
  const BodyFatPercentageRecord({
    required super.time,
    required super.metadata,
    required this.percentage,
    super.id = HealthRecordId.none,
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

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
