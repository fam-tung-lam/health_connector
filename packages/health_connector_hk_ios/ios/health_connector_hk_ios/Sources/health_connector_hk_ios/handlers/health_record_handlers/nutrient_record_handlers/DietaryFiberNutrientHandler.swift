import Foundation
import HealthKit

final class DietaryFiberNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = DietaryFiberNutrientRecordDto
    typealias SampleType = HKQuantitySample

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .dietaryFiber

    static let aggregationMetricConfig: AggregationMetricConfig = .cumulativeSum

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try Self.aggregationMetricConfig.options(for: metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        let quantity = try Self.aggregationMetricConfig.extractQuantity(from: statistics, for: metric)
        return quantity.toMassDto()
    }
}
