import Foundation
import HealthKit

/// Handler for running ground contact time data (interval quantity type)
final class RunningGroundContactTimeHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = RunningGroundContactTimeRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .runningGroundContactTime

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.avg, .min, .max]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        quantity.doubleValue(for: .second())
    }
}
