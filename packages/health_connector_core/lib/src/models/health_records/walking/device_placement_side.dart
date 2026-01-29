part of '../health_record.dart';

/// Defines the placement side of a device used for health measurements.
///
/// This enum represents the physical placement position of a health
/// monitoring device or sensor on the body.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: Maps to `HKDevicePlacementSide`
/// - **Android Health Connect**: Not applicable (iOS-specific metadata)
///
/// ## Usage Example
///
/// ```dart
/// final record = WalkingAsymmetryPercentageRecord(
///   percentage: Percentage.fromDecimal(0.15),
///   devicePlacementSide: DevicePlacementSide.left,
///   startTime: DateTime.now().subtract(Duration(minutes: 5)),
///   endTime: DateTime.now(),
/// );
/// ```
///
/// {@category Health Records}
@sinceV3_2_0
enum DevicePlacementSide {
  /// The placement side is unknown or not specified.
  unknown,

  /// The device is placed centrally on the body.
  central,

  /// The device is placed on the left side of the body.
  left,

  /// The device is placed on the right side of the body.
  right,
}
