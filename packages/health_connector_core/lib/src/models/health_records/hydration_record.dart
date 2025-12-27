part of 'health_record.dart';

/// Represents a hydration (water intake) measurement over a time interval.
///
/// Tracks the volume of water consumed during a specific time period.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`HydrationRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HydrationRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.dietaryWater`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarywater)
///
/// ## Example
///
/// ```dart
/// final record = HydrationRecord(
///   id: HealthRecordId.none,
///   startTime: DateTime.now().subtract(Duration(minutes: 30)),
///   endTime: DateTime.now(),
///   volume: Volume.milliliters(500),
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.hydration_tracker'),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [HydrationHealthDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class HydrationRecord extends IntervalHealthRecord {
  /// Creates a hydration record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [volume]: The volume of water consumed during the interval.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  const HydrationRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.volume,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The volume of water consumed.
  final Volume volume;

  /// Creates a copy with the given fields replaced with the new values.
  HydrationRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Volume? volume,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return HydrationRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      metadata: metadata ?? this.metadata,
      volume: volume ?? this.volume,
      id: id ?? this.id,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HydrationRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          volume == other.volume &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      volume.hashCode ^
      metadata.hashCode;
}
