import Foundation
import HealthKit

/// Handler for respiratory rate data (instant quantity type)
final class RespiratoryRateHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = RespiratoryRateRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .respiratoryRate

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        let rpm = quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
        return rpm
    }
}
