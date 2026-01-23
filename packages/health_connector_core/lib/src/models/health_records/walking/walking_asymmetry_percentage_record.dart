part of '../health_record.dart';

/// Represents a Walking Asymmetry Percentage measurement over a time interval.
///
/// Tracks the percentage of steps where one footstrike is moving at a
/// different speed than the other. This metric helps assess gait symmetry
/// and can indicate potential mobility issues or injury recovery progress.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.walkingAsymmetryPercentage`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/walkingasymmetrypercentage)
///
/// ## Example
///
/// ```dart
/// // Read Walking Asymmetry Percentage records
/// final request =
///     HealthDataType.walkingAsymmetryPercentage.readInTimeRange(
///   startTime: DateTime.now().subtract(Duration(days: 7)),
///   endTime: DateTime.now(),
/// );
/// final response = await connector.readRecords(request);
///
/// for (final record in response.records) {
///   print('Walking asymmetry: ${record.percentage.asWhole}%');
///   print('Device side: ${record.devicePlacementSide}');
/// }
/// ```
///
/// ## See also
///
/// - [WalkingAsymmetryPercentageDataType]
/// - [DevicePlacementSide]
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnAppleHealth
@readOnly
@immutable
final class WalkingAsymmetryPercentageRecord extends IntervalHealthRecord {
  /// Internal factory for creating [WalkingAsymmetryPercentageRecord]
  /// instances without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory WalkingAsymmetryPercentageRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Percentage percentage,
    required DevicePlacementSide devicePlacementSide,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return WalkingAsymmetryPercentageRecord._(
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

  WalkingAsymmetryPercentageRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.percentage,
    required this.devicePlacementSide,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The walking asymmetry percentage.
  final Percentage percentage;

  /// The placement side of the device used to measure walking asymmetry.
  final DevicePlacementSide devicePlacementSide;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingAsymmetryPercentageRecord &&
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
