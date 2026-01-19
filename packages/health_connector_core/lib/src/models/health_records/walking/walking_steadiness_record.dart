part of '../health_record.dart';

/// Represents an Apple Walking Steadiness measurement over a time interval.
///
/// Tracks the user's walking steadiness as a percentage, which measures the
/// stability and regularity of a person's gait. Apple Walking Steadiness is
/// calculated by Apple's internal algorithms based on walking pattern data.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.appleWalkingSteadiness`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/applewalkingsteadiness)
///
/// ## Example
///
/// ```dart
/// // Read Apple Walking Steadiness records
/// final request = HealthDataType.walkingSteadiness.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Walking steadiness: ${record.percentage.asWhole}%');
/// }
/// ```
///
/// ## See also
///
/// - [WalkingSteadinessDataType]
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@readOnly
@immutable
final class WalkingSteadinessRecord extends IntervalHealthRecord {
  /// Internal factory for creating [WalkingSteadinessRecord] instances
  /// without validation.
  ///
  /// Creates an [WalkingSteadinessRecord] by directly mapping platform
  /// data to fields, bypassing the normal validation and business rules
  /// applied by the public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [WalkingSteadinessRecord] constructor, which enforces validation
  /// and business rules. This factory is restricted to the SDK developers
  /// and contributors.
  @internalUse
  factory WalkingSteadinessRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Percentage percentage,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return WalkingSteadinessRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      percentage: percentage,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  WalkingSteadinessRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.percentage,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The walking steadiness percentage.
  final Percentage percentage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingSteadinessRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          percentage == other.percentage;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      percentage.hashCode;
}
