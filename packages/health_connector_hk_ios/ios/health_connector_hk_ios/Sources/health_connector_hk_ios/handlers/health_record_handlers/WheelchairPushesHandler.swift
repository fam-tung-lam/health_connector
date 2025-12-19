import Foundation
import HealthKit

/// Handler for wheelchair pushes data
final class WheelchairPushesHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = WheelchairPushesRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = NumericDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .wheelchairPushes

    static let aggregationMetricConfig: AggregationMetricConfig = .cumulativeSum

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> NumericDto {
        let quantity = try Self.aggregationMetricConfig.extractQuantity(from: statistics, for: metric)
        let count = quantity.doubleValue(for: .count())
        return NumericDto(unit: .numeric, value: count)
    }
}
