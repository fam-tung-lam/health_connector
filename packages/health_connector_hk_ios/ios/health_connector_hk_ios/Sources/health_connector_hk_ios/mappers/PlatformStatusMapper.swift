import Foundation

/// Extension to convert `HealthPlatformStatusDto` to HealthKit status representation.
extension HealthPlatformStatusDto {
    /// Converts a HealthKit availability boolean to a `HealthPlatformStatusDto`.
    static func fromHealthKitAvailability(_ isAvailable: Bool) -> HealthPlatformStatusDto {
        isAvailable ? .available : .notAvailable
    }
}
