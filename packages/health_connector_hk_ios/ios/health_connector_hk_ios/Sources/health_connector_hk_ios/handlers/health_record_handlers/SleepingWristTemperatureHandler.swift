import Foundation
import HealthKit

/// Handler for Sleeping Wrist Temperature data (interval quantity type)
final class SleepingWristTemperatureHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = SleepingWristTemperatureRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .sleepingWristTemperature

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.avg, .min, .max]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        quantity.doubleValue(for: .degreeCelsius())
    }
}
