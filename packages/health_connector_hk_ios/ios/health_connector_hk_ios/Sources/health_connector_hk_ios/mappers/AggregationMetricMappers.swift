import Foundation
import HealthKit

/**
 * Extension to convert `AggregationMetricDto` to HealthKit aggregation options.
 *
 * Note: HealthKit uses different aggregation approaches than Android Health Connect.
 * This mapper adapts the DTO to HealthKit's query-based aggregation.
 */
extension AggregationMetricDto {
    /**
     * Gets the HealthKit statistics options for this aggregation metric.
     *
     * HealthKit uses `HKStatisticsOptions` for aggregation queries, which differ
     * from Android's direct metric constants.
     *
     * - Parameter dataType: The health data type for which to get aggregation options
     * - Returns: The appropriate `HKStatisticsOptions` for the aggregation metric.
     *            Returns empty options ([]) if the metric requires reading records instead.
     * - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if the data type does not support aggregation
     */
    func toHealthKitStatisticsOptions(dataType: HealthDataTypeDto) throws -> HKStatisticsOptions {
        switch dataType {
        case .activeCaloriesBurned:
            switch self {
            case .sum:
                return .cumulativeSum
            case .avg, .min, .max, .count:
                // These require reading individual records and calculating
                // HealthKit doesn't provide direct aggregation for these on active calories burned
                return []
            }

        case .steps:
            switch self {
            case .sum:
                return .cumulativeSum
            case .avg, .min, .max, .count:
                // These require reading individual records and calculating
                // HealthKit doesn't provide direct aggregation for these on steps
                return []
            }

        case .weight:
            switch self {
            case .avg:
                return .discreteAverage
            case .min:
                return .discreteMin
            case .max:
                return .discreteMax
            case .sum, .count:
                // SUM not meaningful for weight, COUNT requires reading records
                return []
            }

        case .height:
            switch self {
            case .avg:
                return .discreteAverage
            case .min:
                return .discreteMin
            case .max:
                return .discreteMax
            case .sum, .count:
                // SUM not meaningful for height, COUNT requires reading records
                return []
            }

        case .bodyFatPercentage:
            switch self {
            case .avg:
                return .discreteAverage
            case .min:
                return .discreteMin
            case .max:
                return .discreteMax
            case .sum, .count:
                // SUM not meaningful for body fat percentage, COUNT requires reading records
                return []
            }

        case .distance:
            switch self {
            case .sum:
                return .cumulativeSum
            case .avg, .min, .max, .count:
                // These require reading individual records and calculating
                // HealthKit doesn't provide direct aggregation for these on distance
                return []
            }

        case .floorsClimbed:
            switch self {
            case .sum:
                return .cumulativeSum
            case .avg, .min, .max, .count:
                // These require reading individual records and calculating
                // HealthKit doesn't provide direct aggregation for these on floors climbed
                return []
            }

        case .wheelchairPushes:
            switch self {
            case .sum:
                return .cumulativeSum
            case .avg, .min, .max, .count:
                // These require reading individual records and calculating
                // HealthKit doesn't provide direct aggregation for these on wheelchair pushes
                return []
            }
        case .hydration:
            switch self {
            case .sum:
                return .cumulativeSum
            case .avg, .min, .max, .count:
                // Only SUM is supported for hydration (matches Android Health Connect behavior)
                return []
            }
        case .leanBodyMass:
            // Lean body mass does not support aggregation
            throw HealthConnectorErrors.invalidArgument(
                message: "Lean body mass does not support aggregation",
                details: "Lean body mass does not support aggregation operations."
            )
        case .bodyTemperature:
            // Body temperature does not support aggregation
            throw HealthConnectorErrors.invalidArgument(
                message: "Body temperature does not support aggregation",
                details: "Body temperature does not support aggregation operations."
            )
        case .heartRateMeasurementRecord:
            switch self {
            case .avg:
                return .discreteAverage
            case .min:
                return .discreteMin
            case .max:
                return .discreteMax
            case .sum, .count:
                // SUM not meaningful for heart rate, COUNT requires reading records
                return []
            }
        case .sleepStageRecord:
            // Sleep stages (category samples) do not support aggregation
            throw HealthConnectorErrors.invalidArgument(
                message: "Sleep stage records do not support aggregation",
                details: "Sleep stage records are category samples and do not support aggregation operations."
            )
        }
    }

    /**
     * Validates if this aggregation metric is valid for the given data type.
     *
     * This matches the Android implementation which only supports metrics that can be
     * performed directly via the platform's aggregation API.
     *
     * - Parameter dataType: The health data type to validate against
     * - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if the metric is invalid
     */
    func validateForDataType(_ dataType: HealthDataTypeDto) throws {
        switch dataType {
        case .activeCaloriesBurned:
            // Only SUM is supported for active calories burned (matches Android Health Connect behavior)
            if self != .sum {
                let metricName = String(describing: self)
                throw HealthConnectorErrors.invalidArgument(
                    message: "\(metricName) not directly supported for activeCaloriesBurned in HealthKit",
                    details: "\(metricName) not directly supported for activeCaloriesBurned in HealthKit."
                )
            }
        case .steps:
            // Only SUM is supported for steps (matches Android Health Connect behavior)
            if self != .sum {
                let metricName = String(describing: self)
                throw HealthConnectorErrors.invalidArgument(
                    message: "\(metricName) not directly supported for steps in HealthKit",
                    details: "\(metricName) not directly supported for steps in HealthKit."
                )
            }
        case .weight:
            // Only AVG, MIN, MAX are supported for weight (matches Android Health Connect behavior)
            switch self {
            case .avg, .min, .max:
                break // These are supported
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorErrors.invalidArgument(
                    message: "\(metricName) not directly supported for weight in HealthKit",
                    details: "\(metricName) not directly supported for weight in HealthKit."
                )
            }
        case .height:
            // Only AVG, MIN, MAX are supported for height (matches Android Health Connect behavior)
            switch self {
            case .avg, .min, .max:
                break // These are supported
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorErrors.invalidArgument(
                    message: "\(metricName) not directly supported for height in HealthKit",
                    details: "\(metricName) not directly supported for height in HealthKit."
                )
            }
        case .bodyFatPercentage:
            // Only AVG, MIN, MAX are supported for body fat percentage (matches Android Health Connect behavior)
            switch self {
            case .avg, .min, .max:
                break // These are supported
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorErrors.invalidArgument(
                    message: "\(metricName) not directly supported for bodyFatPercentage in HealthKit",
                    details: "\(metricName) not directly supported for bodyFatPercentage in HealthKit."
                )
            }
        case .distance:
            // Only SUM is supported for distance (matches Android Health Connect behavior)
            if self != .sum {
                let metricName = String(describing: self)
                throw HealthConnectorErrors.invalidArgument(
                    message: "\(metricName) not directly supported for distance in HealthKit",
                    details: "\(metricName) not directly supported for distance in HealthKit."
                )
            }
        case .floorsClimbed:
            // Only SUM is supported for floors climbed (matches Android Health Connect behavior)
            if self != .sum {
                let metricName = String(describing: self)
                throw HealthConnectorErrors.invalidArgument(
                    message: "\(metricName) not directly supported for floorsClimbed in HealthKit",
                    details: "\(metricName) not directly supported for floorsClimbed in HealthKit."
                )
            }
        case .wheelchairPushes:
            // Only SUM is supported for wheelchair pushes (matches Android Health Connect behavior)
            if self != .sum {
                let metricName = String(describing: self)
                throw HealthConnectorErrors.invalidArgument(
                    message: "\(metricName) not directly supported for wheelchairPushes in HealthKit",
                    details: "\(metricName) not directly supported for wheelchairPushes in HealthKit."
                )
            }
        case .hydration:
            // Only SUM is supported for hydration (matches Android Health Connect behavior)
            if self != .sum {
                let metricName = String(describing: self)
                throw HealthConnectorErrors.invalidArgument(
                    message: "\(metricName) not directly supported for hydration in HealthKit",
                    details: "\(metricName) not directly supported for hydration in HealthKit."
                )
            }
        case .leanBodyMass:
            // Lean body mass does not support aggregation
            throw HealthConnectorErrors.invalidArgument(
                message: "Lean body mass does not support aggregation",
                details: "Lean body mass does not support aggregation operations."
            )
        case .bodyTemperature:
            // Body temperature does not support aggregation
            throw HealthConnectorErrors.invalidArgument(
                message: "Body temperature does not support aggregation",
                details: "Body temperature does not support aggregation operations."
            )
        case .heartRateMeasurementRecord:
            // Only AVG, MIN, MAX are supported for heart rate (matches Android Health Connect behavior)
            switch self {
            case .avg, .min, .max:
                break // These are supported
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorErrors.invalidArgument(
                    message: "\(metricName) not directly supported for heartRateMeasurementRecord in HealthKit",
                    details: "\(metricName) not directly supported for heartRateMeasurementRecord in HealthKit."
                )
            }
        case .sleepStageRecord:
            // Sleep stages (category samples) do not support aggregation
            throw HealthConnectorErrors.invalidArgument(
                message: "Sleep stage records do not support aggregation",
                details: "Sleep stage records are category samples and do not support aggregation operations."
            )
        }
    }
}

