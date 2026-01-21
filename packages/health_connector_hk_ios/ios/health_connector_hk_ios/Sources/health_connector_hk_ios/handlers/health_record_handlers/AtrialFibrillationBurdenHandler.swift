import Foundation
import HealthKit

/// Handler for Atrial Fibrillation Burden data
final class AtrialFibrillationBurdenHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = AtrialFibrillationBurdenRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .atrialFibrillationBurden

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        let percentage = quantity.doubleValue(for: .percent())
        return percentage
    }
}
