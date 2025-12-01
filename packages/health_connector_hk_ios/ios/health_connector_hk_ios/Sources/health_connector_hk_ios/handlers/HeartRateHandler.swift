import Foundation
import HealthKit

/// Handler for heart rate measurement data (instant quantity type)
///
/// **Data Type:** Heart Rate Measurement
/// **Record Pattern:** Instant (single timestamp, no duration)
/// **Aggregation:** Average, Min, Max (discrete values)
/// **HealthKit Type:** HKQuantityTypeIdentifier.heartRate
///
/// **Usage:**
/// - Reading: Retrieves heart rate measurements at specific points in time
/// - Writing: Records heart rate measurements (beats per minute)
/// - Aggregating: Supports avg (resting heart rate), min (lowest BPM), max (peak BPM)
/// - Pagination: Uses time (not endTime) for cursor-based pagination
///
/// **Example:**
/// - Heart rate measurement at 10:30 AM: 72 BPM
/// - time: 10:30 AM (single timestamp)
///
/// **Key Difference from Interval Records:**
/// - Instant records have same startDate and endDate
/// - Uses `.time` field for pagination (not `.endTime`)
/// - Aggregation uses discrete statistics (not cumulative)
///
/// **Note:** This is different from Heart Rate Variability (HRV) or Resting Heart Rate,
/// which are separate HealthKit data types.
struct HeartRateHandler: HealthKitQuantityHandler {
    // MARK: - HealthKitTypeHandler

    static var supportedType: HealthDataTypeDto {
        return .heartRateMeasurementRecord
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
        return quantitySample.toHeartRateMeasurementRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        // Type guard: Verify this is a HeartRateMeasurementRecordDto
        guard let heartRateDto = dto as? HeartRateMeasurementRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected HeartRateMeasurementRecordDto, got \(type(of: dto))"
            )
        }

        // Delegate to existing mapper extension
        // This mapper is already implemented in HealthRecordMappers.swift
        return try heartRateDto.toHealthKit()
    }

    static func getSampleType() -> HKSampleType {
        // Heart rate uses the heartRate quantity type
        // Unit: count/min (beats per minute)
        return HKQuantityType.quantityType(forIdentifier: .heartRate)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        // Type guard: Verify this is a HeartRateMeasurementRecordDto
        guard let heartRateDto = dto as? HeartRateMeasurementRecordDto else {
            return 0
        }

        // Instant records use 'time' field for pagination (NOT endTime!)
        // This is the key difference from interval records like Steps
        return heartRateDto.time
    }

    // MARK: - HealthKitQuantityHandler (Aggregation Support)

    static func supportedAggregations() -> [AggregationMetricDto] {
        // Heart rate is discrete data - average, min, max make sense
        // Examples:
        // - .avg: "Resting heart rate" or "Average heart rate during workout"
        // - .min: "Lowest heart rate recorded"
        // - .max: "Peak heart rate during exercise"
        return [.avg, .min, .max]
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions {
        switch metric {
        case .avg:
            // Discrete average for average heart rate
            return .discreteAverage
        case .min:
            // Discrete minimum for lowest heart rate
            return .discreteMin
        case .max:
            // Discrete maximum for highest/peak heart rate
            return .discreteMax
        default:
            // Sum doesn't make sense for heart rate (not cumulative)
            return []
        }
    }
}
