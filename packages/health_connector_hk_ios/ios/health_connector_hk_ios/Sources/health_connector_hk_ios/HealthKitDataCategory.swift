import Foundation
import HealthKit

/// Categories of health data based on HealthKit API patterns
///
/// These categories determine how data is queried, stored, and deleted in HealthKit.
/// Each category uses different HealthKit APIs and has different characteristics.
enum HealthKitDataCategory {
    /**
     * HKQuantitySample - Supports aggregation (sum, avg, min, max)
     *
     * Examples: steps, weight, heart rate, distance
     * - Uses HKStatisticsQuery for aggregations
     * - Can be deleted in batch operations
     */
    case quantitySample

    /**
     * HKCategorySample - No aggregation support
     *
     * Examples: sleep analysis, menstrual flow
     * - Simple categorical data (enum values)
     * - Can be deleted in batch operations
     */
    case categorySample

    /**
     * HKCorrelation - Contains multiple related samples
     *
     * Examples: blood pressure (systolic + diastolic), food (nutritional components)
     * - Special delete logic required (must delete correlation AND contained samples)
     * - Cannot use batch delete (must iterate)
     */
    case correlation

    /**
     * HKWorkout - Exercise sessions with extra fields
     *
     * Examples: running workout, cycling workout
     * - Contains duration, distance, calories, route data
     * - Can be deleted in batch operations
     */
    case workout

    /**
     * Characteristic - Read-only data accessed directly
     *
     * Examples: biological sex, date of birth, blood type
     * - Not a sample type (no UUID, no timestamps)
     * - Cannot be written or deleted
     * - Uses direct HKHealthStore properties instead of queries
     */
    case characteristic
}

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
            throw HealthConnectorError.invalidArgument(
                message: "Failed to create quantity type for identifier: \(identifier.rawValue)",
                context: [
                    "details": "This identifier may not be available on the current iOS version",
                ]
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
            throw HealthConnectorError.invalidArgument(
                message: "Failed to create category type for identifier: \(identifier.rawValue)",
                context: [
                    "details": "This identifier may not be available on the current iOS version",
                ]
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
            throw HealthConnectorError.invalidArgument(
                message: "Failed to create correlation type for identifier: \(identifier.rawValue)",
                context: [
                    "details": "This identifier may not be available on the current iOS version",
                ]
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
            throw HealthConnectorError.invalidArgument(
                message: "Invalid sleep analysis raw value: \(rawValue)",
                context: [
                    "details":
                        "This sleep stage value may not be supported on the current iOS version",
                ]
            )
        }
        return value
    }
}
