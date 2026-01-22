import Foundation
import HealthKit

/// Handler for heart rate recovery one minute data (interval quantity type)
final class HeartRateRecoveryOneMinuteHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = HeartRateRecoveryOneMinuteRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .heartRateRecoveryOneMinute

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.avg, .min, .max]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        let bpm = quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
        return bpm
    }
}
