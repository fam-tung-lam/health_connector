import Foundation
import HealthKit

/**
 * Handler for diastolic blood pressure (instant quantity type)
 */
struct DiastolicBloodPressureHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto {
        .diastolicBloodPressure
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
        guard let dto = quantitySample.toDiastolicBloodPressureRecordDto() else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Failed to convert HKQuantitySample to DiastolicBloodPressureRecordDto")
        }
        return dto
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let diastolicDto = dto as? DiastolicBloodPressureRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected DiastolicBloodPressureRecordDto, got \(type(of: dto))"
            )
        }
        return try diastolicDto.toHealthKit()
    }

    static func getSampleType() throws -> HKSampleType {
        try HKQuantityType.safeQuantityType(forIdentifier: .bloodPressureDiastolic)
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let diastolicDto = dto as? DiastolicBloodPressureRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected DiastolicBloodPressureRecordDto, got \(type(of: dto))"
            )
        }
        return diastolicDto.time
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
                message: "Aggregation metric '\(metric)' not supported for diastolic blood pressure (discrete data)",
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
                message: "Aggregation metric '\(metric)' not supported for diastolic blood pressure",
                details: "Supported metrics: avg, min, max"
            )
        }

        guard let quantity else {
            throw HealthConnectorErrors.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                details: "Statistics returned nil for bloodPressureDiastolic"
            )
        }

        return quantity.toPressureDto()
    }
}
