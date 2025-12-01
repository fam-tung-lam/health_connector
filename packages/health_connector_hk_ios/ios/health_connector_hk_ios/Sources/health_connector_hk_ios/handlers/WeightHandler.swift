import Foundation
import HealthKit

/// Handler for weight data (instant quantity type)
///
/// **Data Type:** Weight (Body Mass)
/// **Record Pattern:** Instant (single timestamp, no duration)
/// **Aggregation:** Average, Min, Max (discrete values)
/// **HealthKit Type:** HKQuantityTypeIdentifier.bodyMass
///
/// **Usage:**
/// - Reading: Retrieves weight measurements at specific points in time
/// - Writing: Records weight measurements
/// - Aggregating: Supports avg (average weight), min (lowest weight), max (highest weight)
/// - Pagination: Uses time (not endTime) for cursor-based pagination
///
/// **Example:**
/// - Weight measurement at 8:00 AM: 70.5 kg
/// - time: 8:00 AM (single timestamp)
///
/// **Key Difference from Interval Records:**
/// - Instant records have same startDate and endDate
/// - Uses `.time` field for pagination (not `.endTime`)
/// - Aggregation uses discrete statistics (not cumulative)
struct WeightHandler: HealthKitQuantityHandler {
    // MARK: - HealthKitTypeHandler

    static var supportedType: HealthDataTypeDto {
        return .weight
    }

    static var category: HealthKitDataCategory {
        return .quantitySample
    }

    // MARK: - HealthKitSampleHandler

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? {
        // Type guard: Verify this is a quantity sample
        guard let quantitySample = sample as? HKQuantitySample else {
            return nil
        }

        // Delegate to existing mapper extension
        // This mapper is already implemented in HealthRecordMappers.swift
        return quantitySample.toWeightRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        // Type guard: Verify this is a WeightRecordDto
        guard let weightDto = dto as? WeightRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected WeightRecordDto, got \(type(of: dto))"
            )
        }

        // Delegate to existing mapper extension
        // This mapper is already implemented in HealthRecordMappers.swift
        return try weightDto.toHealthKit()
    }

    static func getSampleType() -> HKSampleType {
        // Weight uses the bodyMass quantity type
        return HKQuantityType.quantityType(forIdentifier: .bodyMass)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        // Type guard: Verify this is a WeightRecordDto
        guard let weightDto = dto as? WeightRecordDto else {
            return 0
        }

        // Instant records use 'time' field for pagination (NOT endTime!)
        // This is the key difference from interval records like Steps
        return weightDto.time
    }

    // MARK: - HealthKitQuantityHandler (Aggregation Support)

    static func supportedAggregations() -> [AggregationMetricDto] {
        // Weight is discrete data - average, min, max make sense
        // (e.g., "Average weight this month", "Lowest weight recorded")
        return [.avg, .min, .max]
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions {
        switch metric {
        case .avg:
            // Discrete average for average weight
            return .discreteAverage
        case .min:
            // Discrete minimum for lowest weight
            return .discreteMin
        case .max:
            // Discrete maximum for highest weight
            return .discreteMax
        default:
            // Sum doesn't make sense for weight (not cumulative)
            return []
        }
    }
}
