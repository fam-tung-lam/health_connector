import Foundation
import HealthKit

/**
 * Handler for body fat percentage data (instant quantity type)
 */
struct BodyFatPercentageHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto {
        .bodyFatPercentage
    }

    static var category: HealthKitDataCategory {
        .quantitySample
    }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorErrors.invalidArgument(message: "Expected HKQuantitySample, got \(type(of: sample))")
        }
        guard let dto = quantitySample.toBodyFatPercentageRecordDto() else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Failed to convert HKQuantitySample to BodyFatPercentageRecordDto")
        }
        return dto
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let bodyFatDto = dto as? BodyFatPercentageRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected BodyFatPercentageRecordDto, got \(type(of: dto))"
            )
        }
        return try bodyFatDto.toHealthKit()
    }

    static func getSampleType() throws -> HKSampleType {
        try HKQuantityType.safeQuantityType(forIdentifier: .bodyFatPercentage)
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let bodyFatDto = dto as? BodyFatPercentageRecordDto else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Expected BodyFatPercentageRecordDto, got \(type(of: dto))")
        }
        return bodyFatDto.time
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        switch metric {
        case .avg:
            return .discreteAverage
        case .min:
            return .discreteMin
        case .max:
            return .discreteMax
        case .sum, .count:
            throw HealthConnectorErrors.invalidArgument(
                message: "Aggregation metric '\(metric)' not supported for body fat percentage (discrete data)",
                details: "Supported metrics: avg, min, max"
            )
        }
    }

    static func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        let quantity: HKQuantity? = switch metric {
        case .avg:
            statistics.averageQuantity()
        case .min:
            statistics.minimumQuantity()
        case .max:
            statistics.maximumQuantity()
        case .sum, .count:
            throw HealthConnectorErrors.invalidArgument(
                message: "Aggregation metric '\(metric)' not supported for body fat percentage",
                details: "Supported metrics: avg, min, max"
            )
        }

        guard let quantity else {
            throw HealthConnectorErrors.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                details: "Statistics returned nil for bodyFatPercentage"
            )
        }

        return quantity.toPercentageDto()
    }
}
