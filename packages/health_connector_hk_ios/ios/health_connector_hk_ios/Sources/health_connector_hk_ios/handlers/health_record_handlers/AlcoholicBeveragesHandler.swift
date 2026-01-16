import Foundation
import HealthKit

/// Handler for alcoholic beverages data (interval quantity type)
final class AlcoholicBeveragesHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = AlcoholicBeveragesRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .alcoholicBeverages

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        let count = quantity.doubleValue(for: .count())
        return count
    }
}
