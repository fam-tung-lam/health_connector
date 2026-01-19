import Foundation
import HealthKit

/// Handler for Apple Move Time data (interval quantity type)
final class MoveTimeHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = MoveTimeRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .moveTime

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        quantity.doubleValue(for: .second())
    }
}
