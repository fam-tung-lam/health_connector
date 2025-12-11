import Foundation
import HealthKit

/// Type-safe factory methods for creating HealthKit types without force unwrapping.
///
/// HealthKit's type creation APIs return optionals, but for standard identifiers
/// they should never return nil. This factory provides safe alternatives that
/// throw descriptive errors instead of force unwrapping, improving crash safety
/// and error diagnostics.
extension HKQuantityType {
    /// Safely creates an HKQuantityType for the given identifier.
    ///
    /// - Parameter identifier: The quantity type identifier
    /// - Returns: The quantity type for the identifier
    /// - Throws: HealthConnectorError.invalidArgument if the type cannot be created
    ///           (e.g., identifier not available on current iOS version)
    static func safeQuantityType(
        forIdentifier identifier: HKQuantityTypeIdentifier
    ) throws -> HKQuantityType {
        guard let type = quantityType(forIdentifier: identifier) else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Failed to create quantity type for identifier: \(identifier.rawValue)",
                details: "This identifier may not be available on the current iOS version"
            )
        }
        return type
    }
}

extension HKCategoryType {
    /// Safely creates an HKCategoryType for the given identifier.
    ///
    /// - Parameter identifier: The category type identifier
    /// - Returns: The category type for the identifier
    /// - Throws: HealthConnectorError.invalidArgument if the type cannot be created
    ///           (e.g., identifier not available on current iOS version)
    static func safeCategoryType(
        forIdentifier identifier: HKCategoryTypeIdentifier
    ) throws -> HKCategoryType {
        guard let type = categoryType(forIdentifier: identifier) else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Failed to create category type for identifier: \(identifier.rawValue)",
                details: "This identifier may not be available on the current iOS version"
            )
        }
        return type
    }
}

extension HKCorrelationType {
    /// Safely creates an HKCorrelationType for the given identifier.
    ///
    /// - Parameter identifier: The correlation type identifier
    /// - Returns: The correlation type for the identifier
    /// - Throws: HealthConnectorError.invalidArgument if the type cannot be created
    ///           (e.g., identifier not available on current iOS version)
    static func safeCorrelationType(
        forIdentifier identifier: HKCorrelationTypeIdentifier
    ) throws -> HKCorrelationType {
        guard let type = correlationType(forIdentifier: identifier) else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Failed to create correlation type for identifier: \(identifier.rawValue)",
                details: "This identifier may not be available on the current iOS version"
            )
        }
        return type
    }
}

extension HKCategoryValueSleepAnalysis {
    /// Safely creates an HKCategoryValueSleepAnalysis from a raw value.
    ///
    /// This is particularly useful for iOS 16+ sleep stage values that may not
    /// be available on older iOS versions.
    ///
    /// - Parameter rawValue: The raw integer value
    /// - Returns: The sleep analysis category value
    /// - Throws: HealthConnectorError.invalidArgument if the raw value is invalid
    static func safeSleepValue(rawValue: Int) throws -> HKCategoryValueSleepAnalysis {
        guard let value = HKCategoryValueSleepAnalysis(rawValue: rawValue) else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Invalid sleep analysis raw value: \(rawValue)",
                details: "This sleep stage value may not be supported on the current iOS version"
            )
        }
        return value
    }
}
