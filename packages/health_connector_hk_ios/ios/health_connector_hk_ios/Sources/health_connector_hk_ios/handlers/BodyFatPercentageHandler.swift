import Foundation
import HealthKit

/// Handler for body fat percentage data (instant quantity type)
///
/// **Data Type:** Body Fat Percentage
/// **Record Pattern:** Instant (single timestamp, no duration)
/// **Aggregation:** Average, Min, Max (discrete values)
/// **HealthKit Type:** HKQuantityTypeIdentifier.bodyFatPercentage
///
/// **Usage:**
/// - Reading: Retrieves body fat percentage measurements at specific points
/// - Writing: Records body fat percentage measurements
/// - Aggregating: Supports avg (average %), min (lowest %), max (highest %)
/// - Pagination: Uses time (not endTime) for cursor-based pagination
///
/// **Example:**
/// - Body fat measurement: 18.5%
/// - time: measurement timestamp (single point)
///
/// **Note:** Usually measured by bioelectrical impedance scales or DEXA scans.
/// Value is stored as decimal (0.185 for 18.5%).
struct BodyFatPercentageHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto { .bodyFatPercentage }
    static var category: HealthKitDataCategory { .quantitySample }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? {
        guard let quantitySample = sample as? HKQuantitySample else { return nil }
        return quantitySample.toBodyFatPercentageRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let bodyFatDto = dto as? BodyFatPercentageRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected BodyFatPercentageRecordDto, got \(type(of: dto))"
            )
        }
        return try bodyFatDto.toHealthKit()
    }

    static func getSampleType() -> HKSampleType {
        return HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        guard let bodyFatDto = dto as? BodyFatPercentageRecordDto else { return 0 }
        return bodyFatDto.time
    }

    static func supportedAggregations() -> [AggregationMetricDto] {
        return [.avg, .min, .max]
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions {
        switch metric {
        case .avg: return .discreteAverage
        case .min: return .discreteMin
        case .max: return .discreteMax
        default: return []
        }
    }
}
