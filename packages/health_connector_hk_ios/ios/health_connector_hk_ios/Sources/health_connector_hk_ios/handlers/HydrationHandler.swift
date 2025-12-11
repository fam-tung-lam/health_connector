import Foundation
import HealthKit

/**
 * Handler for hydration data (interval quantity type)
 */
struct HydrationHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto {
        .hydration
    }

    static var category: HealthKitDataCategory {
        .quantitySample
    }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorErrors.invalidArgument(message: "Expected HKQuantitySample, got \(type(of: sample))")
        }
        guard let dto = quantitySample.toHydrationRecordDto() else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Failed to convert HKQuantitySample to HydrationRecordDto")
        }
        return dto
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let hydrationDto = dto as? HydrationRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected HydrationRecordDto, got \(type(of: dto))"
            )
        }
        return try hydrationDto.toHealthKit()
    }

    static func getSampleType() throws -> HKSampleType {
        try HKQuantityType.safeQuantityType(forIdentifier: .dietaryWater)
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let hydrationDto = dto as? HydrationRecordDto else {
            throw HealthConnectorErrors.invalidArgument(message: "Expected HydrationRecordDto, got \(type(of: dto))")
        }
        return hydrationDto.endTime
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        switch metric {
        case .sum:
            return .cumulativeSum
        case .avg, .min, .max, .count:
            throw HealthConnectorErrors.invalidArgument(
                message: "Aggregation metric '\(metric)' not supported for hydration (cumulative data)",
                details: "Only 'sum' is supported"
            )
        }
    }

    static func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        let quantity: HKQuantity? = switch metric {
        case .sum:
            statistics.sumQuantity()
        case .avg, .min, .max, .count:
            throw HealthConnectorErrors.invalidArgument(
                message: "Aggregation metric '\(metric)' not supported for hydration",
                details: "Only 'sum' is supported"
            )
        }

        guard let quantity else {
            throw HealthConnectorErrors.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                details: "Statistics returned nil for dietaryWater"
            )
        }

        let liters = quantity.doubleValue(for: .liter())
        return VolumeDto(unit: .liters, value: liters)
    }
}
