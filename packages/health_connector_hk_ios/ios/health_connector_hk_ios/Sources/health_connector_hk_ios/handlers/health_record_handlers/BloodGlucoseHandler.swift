import Foundation
import HealthKit

/// Handler for blood glucose data (instant quantity type)
final class BloodGlucoseHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = BloodGlucoseRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = BloodGlucoseDto

    /// The HealthKit store for all operations
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .bloodGlucose

    static let aggregationMetricConfig: AggregationMetricConfig = .discreteMinMaxAvg

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> BloodGlucoseDto {
        let quantity = try Self.aggregationMetricConfig.extractQuantity(from: statistics, for: metric)
        return quantity.toBloodGlucoseDto()
    }
}
