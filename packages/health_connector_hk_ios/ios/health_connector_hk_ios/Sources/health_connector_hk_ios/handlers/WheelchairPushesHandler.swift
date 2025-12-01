import Foundation
import HealthKit

/// Handler for wheelchair pushes data (interval quantity type)
///
/// **Data Type:** Wheelchair Pushes
/// **Record Pattern:** Interval (has startTime and endTime)
/// **Aggregation:** Sum only (cumulative pushes)
/// **HealthKit Type:** HKQuantityTypeIdentifier.pushCount
///
/// **Usage:**
/// - Reading: Retrieves wheelchair pushes over time intervals
/// - Writing: Records wheelchair pushes during activities
/// - Aggregating: Supports sum (total pushes)
/// - Pagination: Uses endTime for cursor-based pagination
///
/// **Example:**
/// - 120 wheelchair pushes from 3:00 PM to 3:15 PM
/// - startTime: 3:00 PM, endTime: 3:15 PM, pushes: 120
///
/// **Note:** This metric is specifically for manual wheelchair users.
/// Measured by Apple Watch with wheelchair mode enabled.
struct WheelchairPushesHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto { .wheelchairPushes }
    static var category: HealthKitDataCategory { .quantitySample }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? {
        guard let quantitySample = sample as? HKQuantitySample else { return nil }
        return quantitySample.toWheelchairPushesRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let pushesDto = dto as? WheelchairPushesRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected WheelchairPushesRecordDto, got \(type(of: dto))"
            )
        }
        return try pushesDto.toHealthKit()
    }

    static func getSampleType() -> HKSampleType {
        return HKQuantityType.quantityType(forIdentifier: .pushCount)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        guard let pushesDto = dto as? WheelchairPushesRecordDto else { return 0 }
        return pushesDto.endTime
    }

    static func supportedAggregations() -> [AggregationMetricDto] {
        return [.sum]
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions {
        return metric == .sum ? .cumulativeSum : []
    }
}
