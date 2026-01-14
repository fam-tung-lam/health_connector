import Foundation
import HealthKit

final class DietaryTotalFatHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = DietaryTotalFatRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .totalFat

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        quantity.doubleValue(for: HKUnit.gram())
    }
}
