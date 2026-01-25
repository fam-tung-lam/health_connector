import Foundation
import HealthKit

/// Handler for peak expiratory flow rate data (interval quantity type)
final class PeakExpiratoryFlowRateHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = PeakExpiratoryFlowRateRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .peakExpiratoryFlowRate

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        let unit = HKUnit.liter().unitDivided(by: HKUnit.second())
        return quantity.doubleValue(for: unit)
    }
}
