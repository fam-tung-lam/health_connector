import Foundation
import HealthKit

/**
 * Handler for resting heart rate data (instant quantity type)
 */
struct RestingHeartRateHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto {
        .restingHeartRate
    }

    static var category: HealthKitDataCategory {
        .quantitySample
    }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected HKQuantitySample, got \(type(of: sample))"
            )
        }
        guard let dto = quantitySample.toRestingHeartRateRecordDto() else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Failed to convert HKQuantitySample to RestingHeartRateRecordDto")
        }
        return dto
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let restingHeartRateDto = dto as? RestingHeartRateRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected RestingHeartRateRecordDto, got \(type(of: dto))"
            )
        }
        return try restingHeartRateDto.toHealthKit()
    }

    static func getSampleType() throws -> HKSampleType {
        try HKQuantityType.safeQuantityType(forIdentifier: .restingHeartRate)
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let restingHeartRateDto = dto as? RestingHeartRateRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected RestingHeartRateRecordDto, got \(type(of: dto))"
            )
        }
        return restingHeartRateDto.time
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
                message: "Aggregation metric '\(metric)' not supported for resting heart rate (discrete data)",
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
                message: "Aggregation metric '\(metric)' not supported for resting heart rate",
                details: "Supported metrics: avg, min, max"
            )
        }

        guard let quantity else {
            throw HealthConnectorErrors.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                details: "Statistics returned nil for restingHeartRate"
            )
        }

        let beatsPerMinute = quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
        return NumericDto(unit: .numeric, value: beatsPerMinute)
    }
}
