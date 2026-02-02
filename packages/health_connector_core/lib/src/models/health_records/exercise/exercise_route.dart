part of '../health_record.dart';

/// Represents a GPS route recorded during an exercise session.
///
/// An exercise route contains a sequence of [ExerciseRouteLocation] points
/// captured during physical activity. Routes are associated with an
/// [ExerciseSessionRecord] and require separate permissions to read/write.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`ExerciseRoute`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ExerciseRoute).
/// - **iOS HealthKit**: [`HKWorkoutRoute`](https://developer.apple.com/documentation/healthkit/hkworkoutroute).
///
/// {@category Health Records}
@sinceV3_8_0
@immutable
final class ExerciseRoute implements HealthPlatformData {
  /// Creates an exercise route with the given locations.
  ///
  /// ## Parameters
  ///
  /// - [locations]: The list of GPS locations in the route.
  ///   Must be ordered chronologically by [ExerciseRouteLocation.time].
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [locations] is empty list.
  /// - [ArgumentError] if [locations] are not in chronological order.
  ExerciseRoute(this.locations) {
    require(
      condition: locations.isNotEmpty,
      value: locations,
      name: 'locations',
      message: 'Locations must not be empty.',
    );

    _validateChronologicalOrder(locations);
  }

  /// Internal factory for creating instances without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory ExerciseRoute.internal(List<ExerciseRouteLocation> locations) {
    return ExerciseRoute._(locations);
  }

  const ExerciseRoute._(this.locations);

  /// Validates that locations are in chronological order.
  ///
  /// Locations with equal timestamps are allowed (common in GPS data).
  static void _validateChronologicalOrder(
    List<ExerciseRouteLocation> locations,
  ) {
    for (var i = 1; i < locations.length; i++) {
      final previous = locations[i - 1];
      final current = locations[i];
      if (current.time.isBefore(previous.time)) {
        throw ArgumentError.value(
          locations,
          'locations',
          'Locations must be in chronological order. '
              'Location at index ${i - 1} (${previous.time}) '
              'is after location at index $i (${current.time}).',
        );
      }
    }
  }

  /// The GPS location points that make up this route.
  ///
  /// Should be ordered chronologically. All location timestamps must fall
  /// within the parent exercise session's time bounds.
  final List<ExerciseRouteLocation> locations;

  /// Returns `true` if the route has no locations.
  bool get isEmpty => locations.isEmpty;

  /// Returns `true` if the route has locations.
  bool get isNotEmpty => locations.isNotEmpty;

  /// The number of location points in the route.
  int get length => locations.length;

  /// The first location in the route, or `null` if empty.
  ExerciseRouteLocation? get first => locations.firstOrNull;

  /// The last location in the route, or `null` if empty.
  ExerciseRouteLocation? get last => locations.lastOrNull;

  /// The total duration of the route.
  ///
  /// Returns [Duration.zero] if the route has fewer than 2 points.
  Duration get duration {
    if (locations.length < 2) {
      return Duration.zero;
    }

    return locations.last.time.difference(locations.first.time);
  }

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
    HealthPlatform.healthConnect,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseRoute &&
          runtimeType == other.runtimeType &&
          const ListEquality<ExerciseRouteLocation>().equals(
            locations,
            other.locations,
          );

  @override
  int get hashCode =>
      const ListEquality<ExerciseRouteLocation>().hash(locations);
}
