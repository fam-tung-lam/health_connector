import Foundation
import HealthKit

// Using convenience initializers or static factory methods allows for idiomatic "try HKQuantityType(...)" usage.
extension HKQuantityType {
    /// Creates an instance for the given identifier, throwing an error if unavailable.
    ///
    /// - Parameter identifier: The quantity type identifier (e.g., .stepCount).
    /// - Throws: `HealthConnectorError.invalidArgument` if the type is unavailable on this device/OS.
    static func make(from identifier: HKQuantityTypeIdentifier) throws -> HKQuantityType {
        guard let type = HKObjectType.quantityType(forIdentifier: identifier) else {
            throw HealthConnectorError.invalidArgument(
                message: "HealthKit quantity type unavailable: \(identifier.rawValue)",
                context: ["identifier": identifier.rawValue]
            )
        }
        return type
    }
}

extension HKCategoryType {
    /// Creates an instance for the given identifier, throwing an error if unavailable.
    static func make(from identifier: HKCategoryTypeIdentifier) throws -> HKCategoryType {
        guard let type = HKObjectType.categoryType(forIdentifier: identifier) else {
            throw HealthConnectorError.invalidArgument(
                message: "HealthKit category type unavailable: \(identifier.rawValue)",
                context: ["identifier": identifier.rawValue]
            )
        }

        return type
    }
}

extension HKCorrelationType {
    /// Creates an instance for the given identifier, throwing an error if unavailable.
    static func make(from identifier: HKCorrelationTypeIdentifier) throws -> HKCorrelationType {
        guard let type = HKObjectType.correlationType(forIdentifier: identifier) else {
            throw HealthConnectorError.invalidArgument(
                message: "HealthKit correlation type unavailable: \(identifier.rawValue)",
                context: ["identifier": identifier.rawValue]
            )
        }
        return type
    }
}

extension HKCategoryValueSleepAnalysis {
    /// Creates an HKCategoryValueSleepAnalysis from a raw value.
    static func make(from rawValue: Int) throws -> HKCategoryValueSleepAnalysis {
        guard let value = HKCategoryValueSleepAnalysis(rawValue: rawValue) else {
            throw HealthConnectorError.invalidArgument(
                message: "Invalid sleep analysis raw value: \(rawValue)",
                context: [
                    "details": "This sleep stage value may not be supported on the current iOS version",
                ]
            )
        }
        return value
    }
}
