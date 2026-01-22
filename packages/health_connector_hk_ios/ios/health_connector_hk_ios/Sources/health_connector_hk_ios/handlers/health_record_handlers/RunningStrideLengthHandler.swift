import Foundation
import HealthKit

/// Handler for running stride length data (interval quantity type)
final class RunningStrideLengthHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = RunningStrideLengthRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .runningStrideLength

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.avg, .min, .max]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        quantity.doubleValue(for: .meter())
    }
}
