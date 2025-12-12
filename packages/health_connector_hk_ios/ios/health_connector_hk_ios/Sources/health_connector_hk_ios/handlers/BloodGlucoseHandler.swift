import Foundation
import HealthKit

/**
 * Handler for blood glucose data (instant quantity type)
 */
struct BloodGlucoseHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto {
        .bloodGlucose
    }

    static var category: HealthKitDataCategory {
        .quantitySample
    }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorErrors.invalidArgument(message: "Expected HKQuantitySample, got \(type(of: sample))")
        }
        guard let dto = quantitySample.toBloodGlucoseRecordDto() else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Failed to convert HKQuantitySample to BloodGlucoseRecordDto")
        }
        return dto
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let bgDto = dto as? BloodGlucoseRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected BloodGlucoseRecordDto, got \(type(of: dto))"
            )
        }
        return try bgDto.toHealthKit()
    }

    static func getSampleType() throws -> HKSampleType {
        try HKQuantityType.safeQuantityType(forIdentifier: .bloodGlucose)
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let bgDto = dto as? BloodGlucoseRecordDto else {
            throw HealthConnectorErrors.invalidArgument(message: "Expected BloodGlucoseRecordDto, got \(type(of: dto))")
        }
        return bgDto.time
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
                message: "Aggregation metric '\(metric)' not supported for blood glucose (discrete data)",
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
                message: "Aggregation metric '\(metric)' not supported for blood glucose",
                details: "Supported metrics: avg, min, max"
            )
        }

        guard let quantity else {
            throw HealthConnectorErrors.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                details: "Statistics returned nil for blood glucose"
            )
        }

        // Uses millimoles per liter as the transfer unit (consistent with mapper)
        return quantity.toBloodGlucoseDto()
    }
}
