import Foundation
import HealthKit

/// Handler for step count data (interval quantity type)
///
/// **Data Type:** Steps
/// **Record Pattern:** Interval (has startTime and endTime)
/// **Aggregation:** Sum only (cumulative count)
/// **HealthKit Type:** HKQuantityTypeIdentifier.stepCount
///
/// **Usage:**
/// - Reading: Retrieves step count samples over time ranges
/// - Writing: Records step counts for specific time intervals
/// - Aggregating: Supports sum (total steps) over date ranges
/// - Pagination: Uses endTime for cursor-based pagination
///
/// **Example:**
/// - Walking 1000 steps from 9:00 AM to 9:15 AM
/// - startTime: 9:00 AM, endTime: 9:15 AM, steps: 1000
struct StepsHandler: HealthKitQuantityHandler {
    // MARK: - HealthKitTypeHandler

    static var supportedType: HealthDataTypeDto {
        return .steps
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
        return quantitySample.toStepRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        // Type guard: Verify this is a StepRecordDto
        guard let stepDto = dto as? StepRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected StepRecordDto, got \(type(of: dto))"
            )
        }

        // Delegate to existing mapper extension
        // This mapper is already implemented in HealthRecordMappers.swift
        return try stepDto.toHealthKit()
    }

    static func getSampleType() -> HKSampleType {
        // Steps use the stepCount quantity type
        return HKQuantityType.quantityType(forIdentifier: .stepCount)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        // Type guard: Verify this is a StepRecordDto
        guard let stepDto = dto as? StepRecordDto else {
            return 0
        }

        // Interval records use endTime for pagination
        // This ensures records are ordered by when they completed
        return stepDto.endTime
    }

    // MARK: - HealthKitQuantityHandler (Aggregation Support)

    static func supportedAggregations() -> [AggregationMetricDto] {
        // Steps are cumulative - only sum makes sense
        // (e.g., "Total steps walked today")
        return [.sum]
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions {
        switch metric {
        case .sum:
            // Cumulative sum for total step count
            return .cumulativeSum
        default:
            // Other metrics (avg, min, max) don't make sense for cumulative data
            return []
        }
    }
}
