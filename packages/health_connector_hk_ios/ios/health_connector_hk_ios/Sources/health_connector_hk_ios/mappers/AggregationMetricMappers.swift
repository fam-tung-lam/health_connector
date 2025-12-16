import Foundation
import HealthKit

/// Extension to convert `AggregationMetricDto` to HealthKit aggregation options.
///
/// Note: HealthKit uses different aggregation approaches than Android Health Connect.
/// This mapper adapts the DTO to HealthKit's query-based aggregation.
extension AggregationMetricDto {
    /**
     * Gets the HealthKit statistics options for this aggregation metric.
     *
     * HealthKit uses `HKStatisticsOptions` for aggregation queries, which differ
     * from Android's direct metric constants.
     *
     * - Parameter dataType: The health data type for which to get aggregation options
     * - Returns: The appropriate `HKStatisticsOptions` for the aggregation metric
     * - Throws: `HealthConnectorError.invalidArgument` if the data type does not support aggregation
     */
    func toHealthKitStatisticsOptions(dataType: HealthDataTypeDto) throws -> HKStatisticsOptions {
        switch dataType {
        case .activeCaloriesBurned:
            switch self {
            case .sum:
                return .cumulativeSum
            case .avg, .min, .max, .count:
                return try throwUnsupportedAggregationError(dataType: dataType)
            }

        case .steps:
            switch self {
            case .sum:
                return .cumulativeSum
            case .avg, .min, .max, .count:
                return try throwUnsupportedAggregationError(dataType: dataType)
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
                return try throwUnsupportedAggregationError(dataType: dataType)
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
                return try throwUnsupportedAggregationError(dataType: dataType)
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
                return try throwUnsupportedAggregationError(dataType: dataType)
            }

        case .distance:
            switch self {
            case .sum:
                return .cumulativeSum
            case .avg, .min, .max, .count:
                return try throwUnsupportedAggregationError(dataType: dataType)
            }

        case .floorsClimbed:
            switch self {
            case .sum:
                return .cumulativeSum
            case .avg, .min, .max, .count:
                return try throwUnsupportedAggregationError(dataType: dataType)
            }

        case .wheelchairPushes:
            switch self {
            case .sum:
                return .cumulativeSum
            case .avg, .min, .max, .count:
                return try throwUnsupportedAggregationError(dataType: dataType)
            }

        case .hydration:
            switch self {
            case .sum:
                return .cumulativeSum
            case .avg, .min, .max, .count:
                return try throwUnsupportedAggregationError(dataType: dataType)
            }

        case .leanBodyMass:
            throw HealthConnectorError.invalidArgument(
                message: "Lean body mass does not support aggregation",
                context: ["details": "Lean body mass does not support aggregation operations."]
            )

        case .bodyTemperature:
            throw HealthConnectorError.invalidArgument(
                message: "Body temperature does not support aggregation",
                context: ["details": "Body temperature does not support aggregation operations."]
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
                return try throwUnsupportedAggregationError(dataType: dataType)
            }

        case .restingHeartRate:
            switch self {
            case .avg:
                return .discreteAverage
            case .min:
                return .discreteMin
            case .max:
                return .discreteMax
            case .sum, .count:
                return try throwUnsupportedAggregationError(dataType: dataType)
            }

        case .oxygenSaturation:
            switch self {
            case .avg:
                return .discreteAverage
            case .min:
                return .discreteMin
            case .max:
                return .discreteMax
            case .sum, .count:
                return try throwUnsupportedAggregationError(dataType: dataType)
            }

        case .respiratoryRate:
            switch self {
            case .avg:
                return .discreteAverage
            case .min:
                return .discreteMin
            case .max:
                return .discreteMax
            case .sum, .count:
                return try throwUnsupportedAggregationError(dataType: dataType)
            }

        case .vo2Max:
            switch self {
            case .avg:
                return .discreteAverage
            case .min:
                return .discreteMin
            case .max:
                return .discreteMax
            case .sum, .count:
                return try throwUnsupportedAggregationError(dataType: dataType)
            }

        case .bloodGlucose:
            switch self {
            case .avg:
                return .discreteAverage
            case .min:
                return .discreteMin
            case .max:
                return .discreteMax
            case .sum, .count:
                return try throwUnsupportedAggregationError(dataType: dataType)
            }

        case .sleepStageRecord:
            throw HealthConnectorError.invalidArgument(
                message: "Sleep stage records do not support aggregation",
                context: [
                    "details":
                        "Sleep stage records are category samples and do not support aggregation operations."
                ]
            )

        case .energyNutrient, .caffeine,
            .protein, .totalCarbohydrate, .totalFat, .saturatedFat,
            .monounsaturatedFat, .polyunsaturatedFat, .cholesterol,
            .dietaryFiber, .sugar,
            .vitaminA, .vitaminB6, .vitaminB12, .vitaminC, .vitaminD,
            .vitaminE, .vitaminK, .thiamin, .riboflavin, .niacin,
            .folate, .biotin, .pantothenicAcid,
            .calcium, .iron, .magnesium, .manganese, .phosphorus,
            .potassium, .selenium, .sodium, .zinc:
            return try getNutrientStatisticsOptions(dataType: dataType)

        case .nutrition:
            throw HealthConnectorError.invalidArgument(
                message: "Nutrition records do not support aggregation",
                context: [
                    "details":
                        "Nutrition records are correlation types and do not support aggregation operations."
                ]
            )

        case .bloodPressure:
            throw HealthConnectorError.invalidArgument(
                message: "Blood pressure records do not support aggregation",
                context: [
                    "details":
                        "Blood pressure records are correlation types and do not support aggregation operations."
                ]
            )

        case .systolicBloodPressure:
            switch self {
            case .avg:
                return .discreteAverage
            case .min:
                return .discreteMin
            case .max:
                return .discreteMax
            case .sum, .count:
                return try throwUnsupportedAggregationError(dataType: dataType)
            }

        case .diastolicBloodPressure:
            switch self {
            case .avg:
                return .discreteAverage
            case .min:
                return .discreteMin
            case .max:
                return .discreteMax
            case .sum, .count:
                return try throwUnsupportedAggregationError(dataType: dataType)
            }
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
            if self != .sum {
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message:
                        "\(metricName) not directly supported for activeCaloriesBurned in HealthKit",
                    context: [
                        "details":
                            "\(metricName) not directly supported for activeCaloriesBurned in HealthKit."
                    ]
                )
            }
        case .steps:
            if self != .sum {
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message: "\(metricName) not directly supported for steps in HealthKit",
                    context: [
                        "details": "\(metricName) not directly supported for steps in HealthKit."
                    ]
                )
            }
        case .weight:
            switch self {
            case .avg, .min, .max:
                try toHKStatisticsOption()
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message: "\(metricName) not directly supported for weight in HealthKit",
                    context: [
                        "details": "\(metricName) not directly supported for weight in HealthKit."
                    ]
                )
            }
        case .height:
            switch self {
            case .avg, .min, .max:
                try toHKStatisticsOption()
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message: "\(metricName) not directly supported for height in HealthKit",
                    context: [
                        "details": "\(metricName) not directly supported for height in HealthKit."
                    ]
                )
            }
        case .bodyFatPercentage:
            switch self {
            case .avg, .min, .max:
                try toHKStatisticsOption()
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message:
                        "\(metricName) not directly supported for bodyFatPercentage in HealthKit",
                    context: [
                        "details":
                            "\(metricName) not directly supported for bodyFatPercentage in HealthKit."
                    ]
                )
            }
        case .distance:
            if self != .sum {
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message: "\(metricName) not directly supported for distance in HealthKit",
                    context: [
                        "details": "\(metricName) not directly supported for distance in HealthKit."
                    ]
                )
            }
        case .floorsClimbed:
            if self != .sum {
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message: "\(metricName) not directly supported for floorsClimbed in HealthKit",
                    context: [
                        "details":
                            "\(metricName) not directly supported for floorsClimbed in HealthKit."
                    ]
                )
            }
        case .wheelchairPushes:
            if self != .sum {
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message:
                        "\(metricName) not directly supported for wheelchairPushes in HealthKit",
                    context: [
                        "details":
                            "\(metricName) not directly supported for wheelchairPushes in HealthKit."
                    ]
                )
            }
        case .hydration:
            if self != .sum {
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message: "\(metricName) not directly supported for hydration in HealthKit",
                    context: [
                        "details":
                            "\(metricName) not directly supported for hydration in HealthKit."
                    ]
                )
            }
        case .leanBodyMass:
            throw HealthConnectorError.invalidArgument(
                message: "Lean body mass does not support aggregation",
                context: ["details": "Lean body mass does not support aggregation operations."]
            )
        case .bodyTemperature:
            // Body temperature does not support aggregation
            throw HealthConnectorError.invalidArgument(
                message: "Body temperature does not support aggregation",
                context: ["details": "Body temperature does not support aggregation operations."]
            )
        case .heartRateMeasurementRecord:
            switch self {
            case .avg, .min, .max:
                try toHKStatisticsOption()
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message:
                        "\(metricName) not directly supported for heartRateMeasurementRecord in HealthKit",
                    context: [
                        "details":
                            "\(metricName) not directly supported for heartRateMeasurementRecord in HealthKit."
                    ]
                )
            }
        case .restingHeartRate:
            switch self {
            case .avg, .min, .max:
                try toHKStatisticsOption()
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message:
                        "\(metricName) not directly supported for restingHeartRate in HealthKit",
                    context: [
                        "details":
                            "\(metricName) not directly supported for restingHeartRate in HealthKit."
                    ]
                )
            }
        case .oxygenSaturation:
            switch self {
            case .avg, .min, .max:
                try toHKStatisticsOption()
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message:
                        "\(metricName) not directly supported for oxygenSaturation in HealthKit",
                    context: [
                        "details":
                            "\(metricName) not directly supported for oxygenSaturation in HealthKit."
                    ]
                )
            }
        case .respiratoryRate:
            switch self {
            case .avg, .min, .max:
                try toHKStatisticsOption()
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message:
                        "\(metricName) not directly supported for respiratoryRate in HealthKit",
                    context: [
                        "details":
                            "\(metricName) not directly supported for respiratoryRate in HealthKit."
                    ]
                )
            }
        case .bloodGlucose:
            switch self {
            case .avg, .min, .max:
                try toHKStatisticsOption()
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message: "\(metricName) not directly supported for bloodGlucose in HealthKit",
                    context: [
                        "details":
                            "\(metricName) not directly supported for bloodGlucose in HealthKit."
                    ]
                )
            }
        case .vo2Max:
            switch self {
            case .avg, .min, .max:
                try toHKStatisticsOption()
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message: "\(metricName) not directly supported for vo2Max in HealthKit",
                    context: [
                        "details": "\(metricName) not directly supported for vo2Max in HealthKit."
                    ]
                )
            }
        case .sleepStageRecord:
            throw HealthConnectorError.invalidArgument(
                message: "Sleep stage records do not support aggregation",
                context: [
                    "details":
                        "Sleep stage records are category samples and do not support aggregation operations."
                ]
            )
        case .energyNutrient, .caffeine,
            .protein, .totalCarbohydrate, .totalFat, .saturatedFat,
            .monounsaturatedFat, .polyunsaturatedFat, .cholesterol,
            .dietaryFiber, .sugar,
            .vitaminA, .vitaminB6, .vitaminB12, .vitaminC, .vitaminD,
            .vitaminE, .vitaminK, .thiamin, .riboflavin, .niacin,
            .folate, .biotin, .pantothenicAcid,
            .calcium, .iron, .magnesium, .manganese, .phosphorus,
            .potassium, .selenium, .sodium, .zinc:
            // Only SUM is supported for nutrients (matches Android Health Connect behavior)
            if self != .sum {
                let metricName = String(describing: self)
                let dataTypeName = String(describing: dataType)
                throw HealthConnectorError.invalidArgument(
                    message:
                        "\(metricName) not directly supported for \(dataTypeName) in HealthKit",
                    context: [
                        "details":
                            "\(metricName) not directly supported for \(dataTypeName) in HealthKit."
                    ]
                )
            }
        case .nutrition:
            throw HealthConnectorError.invalidArgument(
                message: "Nutrition records do not support aggregation",
                context: [
                    "details":
                        "Nutrition records are correlation types and do not support aggregation operations."
                ]
            )
        case .bloodPressure:
            throw HealthConnectorError.invalidArgument(
                message: "Blood pressure records do not support aggregation",
                context: [
                    "details":
                        "Blood pressure records are correlation types and do not support aggregation operations."
                ]
            )
        case .systolicBloodPressure:
            switch self {
            case .avg, .min, .max:
                try toHKStatisticsOption()
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message:
                        "\(metricName) not directly supported for systolicBloodPressure in HealthKit",
                    context: [
                        "details":
                            "\(metricName) not directly supported for systolicBloodPressure in HealthKit."
                    ]
                )
            }
        case .diastolicBloodPressure:
            switch self {
            case .avg, .min, .max:
                try toHKStatisticsOption()
            case .sum, .count:
                let metricName = String(describing: self)
                throw HealthConnectorError.invalidArgument(
                    message:
                        "\(metricName) not directly supported for diastolicBloodPressure in HealthKit",
                    context: [
                        "details":
                            "\(metricName) not directly supported for diastolicBloodPressure in HealthKit."
                    ]
                )
            }
        }
    }

    private func getNutrientStatisticsOptions(dataType: HealthDataTypeDto) throws
        -> HKStatisticsOptions
    {
        switch self {
        case .sum:
            try toHKStatisticsOption()
        case .avg, .min, .max, .count:
            try throwUnsupportedAggregationError(dataType: dataType)
        }
    }

    private func throwUnsupportedAggregationError(dataType: HealthDataTypeDto) throws
        -> HKStatisticsOptions
    {
        let metricName = String(describing: self)
        let dataTypeName = String(describing: dataType)
        throw HealthConnectorError.invalidArgument(
            message: "\(metricName) not directly supported for \(dataTypeName) in HealthKit",
            context: [
                "details": "\(metricName) not directly supported for \(dataTypeName) in HealthKit."
            ]
        )
    }

    /**
     * Maps the aggregation metric directly to HealthKit statistics options.
     *
     * - Returns: The corresponding `HKStatisticsOptions`.
     */
    func toHKStatisticsOption() throws -> HKStatisticsOptions {
        switch self {
        case .sum:
            return .cumulativeSum
        case .avg:
            return .discreteAverage
        case .min:
            return .discreteMin
        case .max:
            return .discreteMax
        case .count:
            let metricName = String(describing: self)
            throw HealthConnectorError.unsupportedOperation(
                message: "\(metricName) not directly supported in HealthKit",
                context: nil
            )
        }
    }
}
