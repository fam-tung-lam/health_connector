import Foundation
import HealthKit

/// Handler for Apple Exercise Time data (interval quantity type)
final class ExerciseTimeHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = ExerciseTimeRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .exerciseTime

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        quantity.doubleValue(for: .second())
    }
}
