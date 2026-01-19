import Foundation
import HealthKit

/// Handler for Apple Walking Steadiness data (interval quantity type)
final class WalkingSteadinessHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = WalkingSteadinessRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .walkingSteadiness

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        quantity.doubleValue(for: HKUnit.percent())
    }
}
