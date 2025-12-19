import Foundation
import HealthKit

/// Handler for lean body mass data (instant quantity type)
final class LeanBodyMassHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = LeanBodyMassRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = MassDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .leanBodyMass

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
