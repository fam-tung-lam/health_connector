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
///     device: Device.fromType(DeviceType.phone),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [HydrationDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class HydrationRecord extends IntervalHealthRecord {
  /// Minimum valid hydration volume (0.0 L).
  static const Volume minVolume = Volume.zero;

  /// Maximum valid hydration volume (20.0 L).
  static const Volume maxVolume = Volume.liters(20.0);

  /// Creates a hydration record.
  ///
  /// ## Parameters
  ///
  /// - [volume]: The volume of water consumed.
  /// - [startTime]: The start of the drinking interval.
  /// - [endTime]: The end of the drinking interval.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [volume] is outside the valid range of
  ///   [minVolume]-[maxVolume].
  /// - [ArgumentError] if [endTime] is not after [startTime].
  HydrationRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.volume,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    require(
      condition: volume >= minVolume && volume <= maxVolume,
      value: volume,
      name: 'volume',
      message:
          'Hydration volume must be between '
          '${minVolume.inLiters.toStringAsFixed(0)}-'
          '${maxVolume.inLiters.toStringAsFixed(0)} L. '
          'Got ${volume.inLiters.toStringAsFixed(2)} L.',
    );
  }

  /// Internal factory for creating [HydrationRecord] instances
  /// without validation.
  ///
  /// Creates a [HydrationRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [HydrationRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory HydrationRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Volume volume,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return HydrationRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      volume: volume,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  HydrationRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.volume,
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
