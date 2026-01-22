import Foundation
import HealthKit

/// Handler for electrodermal activity records.
///
/// Electrodermal activity measures the conductance of the user's skin, which
/// increases as the activity of the sweat glands increases.
final class ElectrodermalActivityHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = ElectrodermalActivityRecordDto
    typealias SampleType = HKQuantitySample

    let healthStore: HKHealthStore

    static let dataType: HealthDataTypeDto = .electrodermalActivity

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        quantity.doubleValue(for: .siemen())
    }
}
