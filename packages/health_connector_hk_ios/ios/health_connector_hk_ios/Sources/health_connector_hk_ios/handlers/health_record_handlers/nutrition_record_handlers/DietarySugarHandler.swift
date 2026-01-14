import Foundation
import HealthKit

final class DietarySugarHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = DietarySugarRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .sugar

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        quantity.doubleValue(for: HKUnit.gram())
    }
}
