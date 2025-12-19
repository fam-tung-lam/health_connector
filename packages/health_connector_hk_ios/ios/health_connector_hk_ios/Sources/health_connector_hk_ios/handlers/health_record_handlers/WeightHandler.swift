import Foundation
import HealthKit

/// Handler for body weight measurements (instantaneous quantity type)
final class WeightHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = WeightRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = MassDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .weight

    static let aggregationMetricConfig: AggregationMetricConfig = .discreteMinMaxAvg

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MassDto {
        let quantity = try Self.aggregationMetricConfig.extractQuantity(from: statistics, for: metric)
        let kilograms = quantity.doubleValue(for: .gramUnit(with: .kilo))
        return MassDto(unit: .kilograms, value: kilograms)
    }
}
