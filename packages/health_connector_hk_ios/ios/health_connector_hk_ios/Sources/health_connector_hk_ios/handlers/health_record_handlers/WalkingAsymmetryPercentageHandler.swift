import Foundation
import HealthKit

/// Handler for Walking Asymmetry Percentage data (interval quantity type)
final class WalkingAsymmetryPercentageHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = WalkingAsymmetryPercentageRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .walkingAsymmetryPercentage

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        quantity.doubleValue(for: HKUnit.percent())
    }
}
