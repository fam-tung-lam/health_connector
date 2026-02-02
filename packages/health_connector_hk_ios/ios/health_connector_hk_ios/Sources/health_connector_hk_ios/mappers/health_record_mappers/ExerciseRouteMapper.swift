import CoreLocation
import Foundation
import HealthKit

/// Extension for mapping `HKWorkoutRoute` locations to `ExerciseRouteDto`.
extension [CLLocation] {
    /// Converts an array of `CLLocation` to `ExerciseRouteDto`.
    func toExerciseRouteDto() -> ExerciseRouteDto {
        ExerciseRouteDto(
            locations: map { $0.toExerciseRouteLocationDto() }
        )
    }
}

/// Extension for mapping `CLLocation` → `ExerciseRouteLocationDto`.
extension CLLocation {
    /// Converts this `CLLocation` to `ExerciseRouteLocationDto`.
    func toExerciseRouteLocationDto() -> ExerciseRouteLocationDto {
        ExerciseRouteLocationDto(
            time: Int64(timestamp.timeIntervalSince1970 * 1000),
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            altitudeMeters: altitude,
            horizontalAccuracyMeters: horizontalAccuracy >= 0 ? horizontalAccuracy : nil,
            verticalAccuracyMeters: verticalAccuracy >= 0 ? verticalAccuracy : nil
        )
    }
}

/// Extension for mapping `ExerciseRouteDto` → `[CLLocation]`.
extension ExerciseRouteDto {
    /// Converts this `ExerciseRouteDto` to an array of `CLLocation`.
    func toCLLocations() -> [CLLocation] {
        locations.map { $0.toCLLocation() }
    }
}

/// Extension for mapping `ExerciseRouteLocationDto` → `CLLocation`.
extension ExerciseRouteLocationDto {
    /// Converts this `ExerciseRouteLocationDto` to `CLLocation`.
    func toCLLocation() -> CLLocation {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let timestamp = Date(timeIntervalSince1970: Double(time) / 1000.0)

        return CLLocation(
            coordinate: coordinate,
            altitude: altitudeMeters ?? 0,
            horizontalAccuracy: horizontalAccuracyMeters ?? -1,
            verticalAccuracy: verticalAccuracyMeters ?? -1,
            timestamp: timestamp
        )
    }
}
