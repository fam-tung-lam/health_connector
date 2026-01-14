import Foundation
import HealthKit

/// Handler for step count data (interval quantity type)
final class StepsHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = StepsRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .steps

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        let count = quantity.doubleValue(for: .count())
        return count
    }
}
