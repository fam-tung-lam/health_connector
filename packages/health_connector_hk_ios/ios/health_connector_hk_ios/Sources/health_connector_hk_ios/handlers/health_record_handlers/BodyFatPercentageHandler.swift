import Foundation
import HealthKit

/// Handler for body fat percentage data (instant quantity type)
final class BodyFatPercentageHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = BodyFatPercentageRecordDto
    typealias SampleType = HKQuantitySample

    /// The HealthKit store for all operations
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .bodyFatPercentage

    static let aggregationMetricConfig: AggregationMetricConfig = .discreteMinMaxAvg

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try Self.aggregationMetricConfig.options(for: metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        let quantity = try Self.aggregationMetricConfig.extractQuantity(from: statistics, for: metric)
        return quantity.toPercentageDto()
    }
}
