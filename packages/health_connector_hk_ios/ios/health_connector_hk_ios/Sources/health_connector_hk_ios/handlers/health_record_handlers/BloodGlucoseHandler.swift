import Foundation
import HealthKit

/// Handler for blood glucose data (instant quantity type)
final class BloodGlucoseHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = BloodGlucoseRecordDto
    typealias SampleType = HKQuantitySample

    /// The HealthKit store for all operations
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .bloodGlucose

    static let aggregationMetricConfig: AggregationMetricConfig = .discreteMinMaxAvg

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try Self.aggregationMetricConfig.options(for: metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        let quantity = try Self.aggregationMetricConfig.extractQuantity(from: statistics, for: metric)
        return quantity.toBloodGlucoseDto()
    }
}
