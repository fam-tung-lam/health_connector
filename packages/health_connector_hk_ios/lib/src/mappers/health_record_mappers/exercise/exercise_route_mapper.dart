import 'package:health_connector_core/health_connector_core_internal.dart'
    show ExerciseRoute, ExerciseRouteLocation, Length;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show ExerciseRouteDto, ExerciseRouteLocationDto;
import 'package:meta/meta.dart' show internal;

/// Extension to convert [ExerciseRouteLocation] to [ExerciseRouteLocationDto].
@internal
extension ExerciseRouteLocationToDto on ExerciseRouteLocation {
  ExerciseRouteLocationDto toDto() {
    return ExerciseRouteLocationDto(
      time: time.millisecondsSinceEpoch,
      latitude: latitude,
      longitude: longitude,
      altitudeMeters: altitude?.inMeters,
      horizontalAccuracyMeters: horizontalAccuracy?.inMeters,
      verticalAccuracyMeters: verticalAccuracy?.inMeters,
    );
  }
}

/// Extension to convert [ExerciseRouteLocationDto] to [ExerciseRouteLocation].
@internal
extension ExerciseRouteLocationFromDto on ExerciseRouteLocationDto {
  ExerciseRouteLocation toDomain() {
    return ExerciseRouteLocation.internal(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      latitude: latitude,
      longitude: longitude,
      altitude: altitudeMeters != null ? Length.meters(altitudeMeters!) : null,
      horizontalAccuracy: horizontalAccuracyMeters != null
          ? Length.meters(horizontalAccuracyMeters!)
          : null,
      verticalAccuracy: verticalAccuracyMeters != null
          ? Length.meters(verticalAccuracyMeters!)
          : null,
    );
  }
}

/// Extension to convert [ExerciseRoute] to [ExerciseRouteDto].
@internal
extension ExerciseRouteToDto on ExerciseRoute {
  ExerciseRouteDto toDto() {
    return ExerciseRouteDto(
      locations: locations.map((l) => l.toDto()).toList(),
    );
  }
}

/// Extension to convert [ExerciseRouteDto] to [ExerciseRoute].
@internal
extension ExerciseRouteFromDto on ExerciseRouteDto {
  ExerciseRoute toDomain() {
    return ExerciseRoute.internal(
      locations.map((l) => l.toDomain()).toList(),
    );
  }
}
