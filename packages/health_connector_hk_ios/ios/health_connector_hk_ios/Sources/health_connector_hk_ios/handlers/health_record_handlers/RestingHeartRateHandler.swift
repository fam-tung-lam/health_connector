import Foundation
import HealthKit

/// Handler for resting heart rate data (instant quantity type)
final class RestingHeartRateHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = RestingHeartRateRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = NumericDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .restingHeartRate

    static let aggregationMetricConfig: AggregationMetricConfig = .discreteMinMaxAvg

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> NumericDto {
        let quantity = try Self.aggregationMetricConfig.extractQuantity(from: statistics, for: metric)
        let beatsPerMinute = quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
        return NumericDto(unit: .numeric, value: beatsPerMinute)
    }
}
