import Foundation
import HealthKit

/// Handler for Apple Stand Time data (interval quantity type)
final class StandTimeHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = StandTimeRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .standTime

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        quantity.doubleValue(for: .second())
    }
}
