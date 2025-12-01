import Foundation
import HealthKit

/// Handler for hydration data (interval quantity type)
///
/// **Data Type:** Hydration (Water/Fluid Intake)
/// **Record Pattern:** Interval (has startTime and endTime)
/// **Aggregation:** Sum only (cumulative volume)
/// **HealthKit Type:** HKQuantityTypeIdentifier.dietaryWater
///
/// **Usage:**
/// - Reading: Retrieves water/fluid intake over time intervals
/// - Writing: Records water consumption
/// - Aggregating: Supports sum (total fluid intake)
/// - Pagination: Uses endTime for cursor-based pagination
///
/// **Example:**
/// - Drinking 500 mL of water at 11:30 AM
/// - startTime: 11:30 AM, endTime: 11:30 AM, volume: 0.5 liters
///
/// **Note:** Typically recorded as instant events (same start/end time),
/// but HealthKit treats it as an interval type for consistency with dietary tracking.
struct HydrationHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto { .hydration }
    static var category: HealthKitDataCategory { .quantitySample }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? {
        guard let quantitySample = sample as? HKQuantitySample else { return nil }
        return quantitySample.toHydrationRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let hydrationDto = dto as? HydrationRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected HydrationRecordDto, got \(type(of: dto))"
            )
        }
        return try hydrationDto.toHealthKit()
    }

    static func getSampleType() -> HKSampleType {
        return HKQuantityType.quantityType(forIdentifier: .dietaryWater)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        guard let hydrationDto = dto as? HydrationRecordDto else { return 0 }
        return hydrationDto.endTime
    }

    static func supportedAggregations() -> [AggregationMetricDto] {
        return [.sum]
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions {
        return metric == .sum ? .cumulativeSum : []
    }
}
