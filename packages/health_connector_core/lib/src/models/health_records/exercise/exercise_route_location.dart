part of '../health_record.dart';

/// Represents a single location point in an exercise route.
///
/// Each location contains GPS coordinates (latitude, longitude), optional
/// altitude, and accuracy information. The [time] must fall within the
/// parent exercise session's time bounds.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`ExerciseRoute.Location`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseRoute.Location)
/// - **iOS HealthKit**: `CLLocation` from [`HKWorkoutRoute`](https://developer.apple.com/documentation/healthkit/hkworkoutroute)
///
/// {@category Health Records}
@sinceV3_8_0
@immutable
final class ExerciseRouteLocation implements HealthPlatformData {
  /// Minimum valid latitude in degrees.
  static const double minLatitudeDegrees = -90.0;

  /// Maximum valid latitude in degrees.
  static const double maxLatitudeDegrees = 90.0;

  /// Minimum valid longitude in degrees.
  static const double minLongitudeDegrees = -180.0;

  /// Maximum valid longitude in degrees.
  static const double maxLongitudeDegrees = 180.0;

  /// Creates an exercise route location.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when this location was recorded.
  /// - [latitude]: The latitude in degrees. Must be between -90 and 90.
  /// - [longitude]: The longitude in degrees. Must be between -180 and 180.
  /// - [altitude]: Optional altitude above sea level.
  /// - [horizontalAccuracy]: Optional horizontal accuracy of the location.
  ///   Valid range: non-negative when present.
  /// - [verticalAccuracy]: Optional vertical accuracy of the altitude.
  ///   Valid range: non-negative when present.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [latitude] is not between -90 and 90.
  /// - [ArgumentError] if [longitude] is not between -180 and 180.
  /// - [ArgumentError] if [horizontalAccuracy] is negative when provided.
  /// - [ArgumentError] if [verticalAccuracy] is negative when provided.
  ExerciseRouteLocation({
    required this.time,
    required this.latitude,
    required this.longitude,
    this.altitude,
    this.horizontalAccuracy,
    this.verticalAccuracy,
  }) {
    require(
      condition:
          latitude >= minLatitudeDegrees && latitude <= maxLatitudeDegrees,
      value: latitude,
      name: 'latitude',
      message:
          'Latitude must be between $minLatitudeDegrees and '
          '$maxLatitudeDegrees degrees. Got $latitude.',
    );
    require(
      condition:
          longitude >= minLongitudeDegrees && longitude <= maxLongitudeDegrees,
      value: longitude,
      name: 'longitude',
      message:
          'Longitude must be between $minLongitudeDegrees and '
          '$maxLongitudeDegrees degrees. Got $longitude.',
    );
    if (horizontalAccuracy != null) {
      final ha = horizontalAccuracy!;
      require(
        condition: ha >= Length.zero,
        value: ha,
        name: 'horizontalAccuracy',
        message:
            'Horizontal accuracy must be non-negative. '
            'Got ${ha.inMeters} m.',
      );
    }
    if (verticalAccuracy != null) {
      final va = verticalAccuracy!;
      require(
        condition: va >= Length.zero,
        value: va,
        name: 'verticalAccuracy',
        message:
            'Vertical accuracy must be non-negative. '
            'Got ${va.inMeters} m.',
      );
    }
  }

  /// Internal factory for creating instances without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory ExerciseRouteLocation.internal({
    required DateTime time,
    required double latitude,
    required double longitude,
    Length? altitude,
    Length? horizontalAccuracy,
    Length? verticalAccuracy,
  }) {
    return ExerciseRouteLocation._(
      time: time,
      latitude: latitude,
      longitude: longitude,
      altitude: altitude,
      horizontalAccuracy: horizontalAccuracy,
      verticalAccuracy: verticalAccuracy,
    );
  }

  const ExerciseRouteLocation._({
    required this.time,
    required this.latitude,
    required this.longitude,
    this.altitude,
    this.horizontalAccuracy,
    this.verticalAccuracy,
  });

  /// The timestamp when this location was recorded.
  ///
  /// Must fall within the parent exercise session's time bounds.
  final DateTime time;

  /// The latitude in degrees.
  ///
  /// Valid range: -90 to 90 degrees.
  final double latitude;

  /// The longitude in degrees.
  ///
  /// Valid range: -180 to 180 degrees.
  final double longitude;

  /// Optional altitude above sea level.
  final Length? altitude;

  /// Optional horizontal accuracy of the GPS reading.
  ///
  /// Lower values indicate more accurate horizontal positioning.
  /// Valid range: non-negative when present.
  final Length? horizontalAccuracy;

  /// Optional vertical accuracy of the altitude reading.
  ///
  /// Lower values indicate more accurate altitude measurements.
  /// Valid range: non-negative when present.
  final Length? verticalAccuracy;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
    HealthPlatform.healthConnect,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseRouteLocation &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          altitude == other.altitude &&
          horizontalAccuracy == other.horizontalAccuracy &&
          verticalAccuracy == other.verticalAccuracy;

  @override
  int get hashCode => Object.hash(
    time,
    latitude,
    longitude,
    altitude,
    horizontalAccuracy,
    verticalAccuracy,
  );
}
