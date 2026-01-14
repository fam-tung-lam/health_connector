import Foundation
import HealthKit

/// Handler for resting heart rate data (instant quantity type)
final class RestingHeartRateHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = RestingHeartRateRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .restingHeartRate

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        let bpm = quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
        return bpm
    }
}
