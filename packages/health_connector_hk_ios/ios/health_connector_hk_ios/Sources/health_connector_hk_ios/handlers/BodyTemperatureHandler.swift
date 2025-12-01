import Foundation
import HealthKit

/// Handler for body temperature data (instant quantity type)
///
/// **Data Type:** Body Temperature
/// **Record Pattern:** Instant (single timestamp, no duration)
/// **Aggregation:** None (no aggregation supported)
/// **HealthKit Type:** HKQuantityTypeIdentifier.bodyTemperature
///
/// **Usage:**
/// - Reading: Retrieves body temperature measurements at specific points
/// - Writing: Records body temperature measurements
/// - Aggregating: NOT supported (individual readings are more meaningful)
/// - Pagination: Uses time (not endTime) for cursor-based pagination
///
/// **Example:**
/// - Body temperature reading: 37.2°C (98.96°F)
/// - time: measurement timestamp (single point)
///
/// **Note:** Body temperature is typically measured orally, rectally, or via ear thermometer.
/// Aggregating temperature readings (avg/min/max) is not medically meaningful,
/// so this handler returns empty array for supported aggregations.
struct BodyTemperatureHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto { .bodyTemperature }
    static var category: HealthKitDataCategory { .quantitySample }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? {
        guard let quantitySample = sample as? HKQuantitySample else { return nil }
        return quantitySample.toBodyTemperatureRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let temperatureDto = dto as? BodyTemperatureRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected BodyTemperatureRecordDto, got \(type(of: dto))"
            )
        }
        return try temperatureDto.toHealthKit()
    }

    static func getSampleType() -> HKSampleType {
        return HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        guard let temperatureDto = dto as? BodyTemperatureRecordDto else { return 0 }
        return temperatureDto.time
    }

    static func supportedAggregations() -> [AggregationMetricDto] {
        // Body temperature aggregations are not medically meaningful
        // Individual readings at specific times are what matters
        return []
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions {
        // No aggregations supported
        return []
    }
}
