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
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .heartRateVariabilitySDNN

    // Supports min, max, avg, sum
    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg, .sum]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        // SDNN is stored in seconds in HealthKit, DTO also expects seconds
        let seconds = quantity.doubleValue(for: .second())
        return seconds * 1000.0 // Convert to millis
    }
}
