import Foundation
import HealthKit

/// Handler for distance data (interval quantity type)
///
/// **Data Type:** Distance (Walking + Running)
/// **Record Pattern:** Interval (has startTime and endTime)
/// **Aggregation:** Sum only (cumulative distance)
/// **HealthKit Type:** HKQuantityTypeIdentifier.distanceWalkingRunning
///
/// **Usage:**
/// - Reading: Retrieves distance traveled over time intervals
/// - Writing: Records distance traveled during activities
/// - Aggregating: Supports sum (total distance)
/// - Pagination: Uses endTime for cursor-based pagination
///
/// **Example:**
/// - Walking 2.5 km from 9:00 AM to 9:30 AM
/// - startTime: 9:00 AM, endTime: 9:30 AM, distance: 2500 meters
///
/// **Note:** This tracks walking and running distance. Cycling and other activities
/// have separate distance types in HealthKit.
struct DistanceHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto { .distance }
    static var category: HealthKitDataCategory { .quantitySample }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? {
        guard let quantitySample = sample as? HKQuantitySample else { return nil }
        return quantitySample.toDistanceRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let distanceDto = dto as? DistanceRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected DistanceRecordDto, got \(type(of: dto))"
            )
        }
        return try distanceDto.toHealthKit()
    }

    static func getSampleType() -> HKSampleType {
        return HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        guard let distanceDto = dto as? DistanceRecordDto else { return 0 }
        return distanceDto.endTime
    }

    static func supportedAggregations() -> [AggregationMetricDto] {
        return [.sum]
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions {
        return metric == .sum ? .cumulativeSum : []
    }
}
