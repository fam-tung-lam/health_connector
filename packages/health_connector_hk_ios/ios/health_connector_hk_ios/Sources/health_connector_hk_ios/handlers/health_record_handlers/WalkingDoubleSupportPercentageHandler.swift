import Foundation
import HealthKit

/// Handler for Walking Double Support Percentage data (interval quantity type)
final class WalkingDoubleSupportPercentageHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = WalkingDoubleSupportPercentageRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .walkingDoubleSupportPercentage

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        quantity.doubleValue(for: HKUnit.percent())
    }
}
