part of '../health_record.dart';

/// Represents a Walking Double Support Percentage measurement over a
/// time interval.
///
/// Tracks the percentage of steps where both feet are on the ground.
/// A lower value generally indicates better balance and stability.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.walkingDoubleSupportPercentage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingdoublesupportpercentage)
///
/// ## Example
///
/// ```dart
/// // Write a Walking Double Support Percentage record
/// final record = WalkingDoubleSupportPercentageRecord(
///   startTime: DateTime.now().subtract(Duration(minutes: 5)),
///   endTime: DateTime.now(),
///   percentage: Percentage.fromWhole(28.5),
///   devicePlacementSide: DevicePlacementSide.left,
///   metadata: Metadata.manualEntry(),
/// );
/// await connector.writeRecords([record]);
///
/// // Read Walking Double Support Percentage records
/// final request =
///     HealthDataType.walkingDoubleSupportPercentage.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Double support: ${record.percentage.asWhole}%');
///   print('Device side: ${record.devicePlacementSide}');
/// }
/// ```
///
/// ## See also
///
/// - [WalkingDoubleSupportPercentageDataType]
/// - [DevicePlacementSide]
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@immutable
final class WalkingDoubleSupportPercentageRecord extends IntervalHealthRecord {
  /// Minimum valid walking double support percentage (0%).
  ///
  /// No double support phase. Very rare in normal gait; typically indicates
  /// running or very fast walking.
  static const Percentage minPercentage = Percentage.zero;

  /// Maximum valid walking double support percentage (100%).
  ///
  /// Continuous double support. Normal range is 20-40% for healthy adults;
  /// values >50% may indicate balance issues.
  static const Percentage maxPercentage = Percentage.full;

  /// Creates a walking double support percentage record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [percentage]: The walking double support percentage measurement.
  /// - [devicePlacementSide]: The placement side of the device used for
  ///   measurement.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [percentage] is outside the valid range of
  ///   [minPercentage]-[maxPercentage]%.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minPercentage]%)**: No double support phase. Very rare in
  ///   normal gait; typically indicates running or very fast walking.
  /// - **Maximum ([maxPercentage]%)**: Continuous double support. Normal range
  ///   is 20-40% for healthy adults; values >50% may indicate balance issues.
  WalkingDoubleSupportPercentageRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.percentage,
    required this.devicePlacementSide,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    require(
      condition: percentage >= minPercentage && percentage <= maxPercentage,
      value: percentage,
      name: 'percentage',
      message:
          'Walking double support percentage must be between '
          '${minPercentage.asWhole.toStringAsFixed(0)}-'
          '${maxPercentage.asWhole.toStringAsFixed(0)}%. '
          'Got ${percentage.asWhole.toStringAsFixed(1)}%.',
    );
  }

  /// Internal factory for creating [WalkingDoubleSupportPercentageRecord]
  /// instances without validation.
  ///
  /// Creates a [WalkingDoubleSupportPercentageRecord] by directly mapping
  /// platform data to fields, bypassing the normal validation and business
  /// rules applied by the public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [WalkingDoubleSupportPercentageRecord] constructor, which enforces
  /// validation and business rules. This factory is restricted to the SDK
  /// developers and contributors.
  /// Public constructor for [WalkingDoubleSupportPercentageRecord].
  @internalUse
  factory WalkingDoubleSupportPercentageRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Percentage percentage,
    required DevicePlacementSide devicePlacementSide,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return WalkingDoubleSupportPercentageRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      percentage: percentage,
      devicePlacementSide: devicePlacementSide,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  WalkingDoubleSupportPercentageRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.percentage,
    required this.devicePlacementSide,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The walking double support percentage.
  final Percentage percentage;

  /// The placement side of the device used to measure walking double support.
  final DevicePlacementSide devicePlacementSide;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingDoubleSupportPercentageRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          percentage == other.percentage &&
          devicePlacementSide == other.devicePlacementSide;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      percentage.hashCode ^
      devicePlacementSide.hashCode;
}
