import Foundation
import HealthKit

/// Handler for walking heart rate average data (interval quantity type)
final class WalkingHeartRateAverageHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = WalkingHeartRateAverageRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .walkingHeartRateAverage

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        let bpm = quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
        return bpm
    }
}
