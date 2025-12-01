import Foundation
import HealthKit

/// Handler for height data (instant quantity type)
///
/// **Data Type:** Height
/// **Record Pattern:** Instant (single timestamp, no duration)
/// **Aggregation:** Average, Min, Max (discrete values)
/// **HealthKit Type:** HKQuantityTypeIdentifier.height
///
/// **Usage:**
/// - Reading: Retrieves height measurements at specific points in time
/// - Writing: Records height measurements
/// - Aggregating: Supports avg (average height), min (shortest), max (tallest)
/// - Pagination: Uses time (not endTime) for cursor-based pagination
///
/// **Example:**
/// - Height measurement at doctor's office: 175 cm
/// - time: appointment timestamp (single point)
///
/// **Note:** Height changes slowly over lifetime (growth in children, shrinkage in elderly).
/// Multiple measurements allow tracking growth or posture changes.
struct HeightHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto { .height }
    static var category: HealthKitDataCategory { .quantitySample }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? {
        guard let quantitySample = sample as? HKQuantitySample else { return nil }
        return quantitySample.toHeightRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let heightDto = dto as? HeightRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected HeightRecordDto, got \(type(of: dto))"
            )
        }
        return try heightDto.toHealthKit()
    }

    static func getSampleType() -> HKSampleType {
        return HKQuantityType.quantityType(forIdentifier: .height)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        guard let heightDto = dto as? HeightRecordDto else { return 0 }
        return heightDto.time
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
