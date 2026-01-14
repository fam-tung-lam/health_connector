import Foundation
import HealthKit

/// Handler for waist circumference data (instant quantity type)
final class WaistCircumferenceHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = WaistCircumferenceRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .waistCircumference

    // Supports min, max, avg, sum
    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg, .sum]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        let meters = quantity.doubleValue(for: .meter())
        return meters
    }
}
