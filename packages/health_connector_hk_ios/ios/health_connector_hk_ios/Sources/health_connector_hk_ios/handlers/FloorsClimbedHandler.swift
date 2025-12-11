import Foundation
import HealthKit

/**
 * Handler for floors climbed data (interval quantity type)
 */
struct FloorsClimbedHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto {
        .floorsClimbed
    }

    static var category: HealthKitDataCategory {
        .quantitySample
    }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorErrors.invalidArgument(message: "Expected HKQuantitySample, got \(type(of: sample))")
        }
        guard let dto = quantitySample.toFloorsClimbedRecordDto() else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Failed to convert HKQuantitySample to FloorsClimbedRecordDto")
        }
        return dto
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let floorsDto = dto as? FloorsClimbedRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected FloorsClimbedRecordDto, got \(type(of: dto))"
            )
        }
        return try floorsDto.toHealthKit()
    }

    static func getSampleType() throws -> HKSampleType {
        try HKQuantityType.safeQuantityType(forIdentifier: .flightsClimbed)
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let floorsDto = dto as? FloorsClimbedRecordDto else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Expected FloorsClimbedRecordDto, got \(type(of: dto))")
        }
        return floorsDto.endTime
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        switch metric {
        case .sum:
            return .cumulativeSum
        case .avg, .min, .max, .count:
            throw HealthConnectorErrors.invalidArgument(
                message: "Aggregation metric '\(metric)' not supported for floors climbed (cumulative data)",
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
                message: "Aggregation metric '\(metric)' not supported for floors climbed",
                details: "Only 'sum' is supported"
            )
        }

        guard let quantity else {
            throw HealthConnectorErrors.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                details: "Statistics returned nil for flightsClimbed"
            )
        }

        let count = quantity.doubleValue(for: .count())
        return NumericDto(unit: .numeric, value: count)
    }
}
