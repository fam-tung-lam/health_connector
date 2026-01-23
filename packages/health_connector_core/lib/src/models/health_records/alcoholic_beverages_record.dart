part of 'health_record.dart';

/// Represents an alcoholic beverages consumption record over a time interval.
///
/// [AlcoholicBeveragesRecord] tracks the number of alcoholic beverages consumed
/// during a specific time period. This is an interval-based record, meaning it
/// has both a start and end time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.numberOfAlcoholicBeverages`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/numberofalcoholicbeverages)
///
/// ## Example
///
/// ```dart
/// final record = AlcoholicBeveragesRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 2)),
///   endTime: DateTime.now(),
///   count: Number(2),
///   metadata: Metadata.manuallyRecorded(),
/// );
/// ```
///
/// ## See also
///
/// - [AlcoholicBeveragesDataType]
/// - [BloodAlcoholContentRecord]
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
final class AlcoholicBeveragesRecord extends IntervalHealthRecord {
  /// Minimum valid alcoholic beverages count (0).
  static const Number minCount = Number.zero;

  /// Maximum valid alcoholic beverages count (100).
  ///
  /// Represents an upper limit with safety margin for tracking purposes.
  static const Number maxCount = Number(100);

  /// Creates an alcoholic beverages consumption record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [count]: The number of alcoholic beverages (must be >= 0).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [count] is negative.
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [count] is outside the valid range of
  ///   [minCount]-[maxCount].
  AlcoholicBeveragesRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.count,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    require(
      condition: count >= minCount && count <= maxCount,
      value: count,
      name: 'count',
      message:
          'Alcoholic beverages count must be between ${minCount.value.toInt()}-'
          '${maxCount.value.toInt()}. '
          'Got ${count.value.toInt()} beverages.',
    );
  }

  /// Internal factory for creating [AlcoholicBeveragesRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory AlcoholicBeveragesRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Number count,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return AlcoholicBeveragesRecord._(
      startTime: startTime,
      endTime: endTime,
      count: count,
      metadata: metadata,
      id: id,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  AlcoholicBeveragesRecord._({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.count,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The number of alcoholic beverages consumed during the interval.
  ///
  /// Must be non-negative (>= 0).
  final Number count;

  /// Creates a copy with the given fields replaced with the new values.
  AlcoholicBeveragesRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Number? count,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return AlcoholicBeveragesRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      count: count ?? this.count,
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
      other is AlcoholicBeveragesRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          count == other.count &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      count.hashCode ^
      metadata.hashCode;
}
