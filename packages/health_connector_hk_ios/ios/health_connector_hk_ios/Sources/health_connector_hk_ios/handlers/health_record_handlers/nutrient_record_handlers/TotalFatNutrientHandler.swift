import Foundation
import HealthKit

final class TotalFatNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = TotalFatNutrientRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = MassDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .totalFat

    static let aggregationMetricConfig: AggregationMetricConfig = .cumulativeSum

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MassDto {
        let quantity = try Self.aggregationMetricConfig.extractQuantity(from: statistics, for: metric)
        return quantity.toMassDto()
    }
}
