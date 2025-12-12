import Foundation
import HealthKit

/**
 * Handler for VO2 Max data (instant quantity type)
 */
struct Vo2MaxHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto {
        .vo2Max
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
        guard let dto = quantitySample.toVo2MaxRecordDto() else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Failed to convert HKQuantitySample to Vo2MaxRecordDto")
        }
        return dto
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let vo2MaxDto = dto as? Vo2MaxRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected Vo2MaxRecordDto, got \(type(of: dto))"
            )
        }
        return try vo2MaxDto.toHealthKit()
    }

    static func getSampleType() throws -> HKSampleType {
        try HKQuantityType.safeQuantityType(forIdentifier: .vo2Max)
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let vo2MaxDto = dto as? Vo2MaxRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected Vo2MaxRecordDto, got \(type(of: dto))"
            )
        }
        return vo2MaxDto.time
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
                message: "Aggregation metric '\(metric)' not supported for VO2 max (discrete data)",
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
                message: "Aggregation metric '\(metric)' not supported for VO2 max",
                details: "Supported metrics: avg, min, max"
            )
        }

        guard let quantity else {
            throw HealthConnectorErrors.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                details: "Statistics returned nil for vo2Max"
            )
        }

        let unit = HKUnit.literUnit(with: .milli)
            .unitDivided(by: HKUnit.gramUnit(with: .kilo).unitMultiplied(by: .minute()))
        let value = quantity.doubleValue(for: unit)
        return Vo2MaxDto(unit: .millilitersPerKilogramPerMinute, value: value)
    }
}
