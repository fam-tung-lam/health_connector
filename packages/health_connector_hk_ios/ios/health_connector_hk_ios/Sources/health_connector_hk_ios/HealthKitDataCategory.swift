import Foundation

/**
 * Categories of health data based on HealthKit API patterns
 *
 * These categories determine how data is queried, stored, and deleted in HealthKit.
 * Each category uses different HealthKit APIs and has different characteristics.
 */
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
