import Foundation
import HealthKit

/// Handler for heart rate variability SDNN data (instant quantity type)
final class HeartRateVariabilitySDNNHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = HeartRateVariabilitySDNNRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = NumberDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .heartRateVariabilitySDNN

    // Supports min, max, avg, sum
    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg, .sum]

    func convertQuantity(_ quantity: HKQuantity) throws -> NumberDto {
        // SDNN is stored in seconds in HealthKit, but DTO expects milliseconds
        let ms = quantity.doubleValue(for: .second()) * 1000.0
        return NumberDto(value: ms)
    }
}
