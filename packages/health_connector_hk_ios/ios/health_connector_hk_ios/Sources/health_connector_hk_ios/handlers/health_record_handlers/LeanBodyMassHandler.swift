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

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> MassDto {
        let kilograms = quantity.doubleValue(for: .gramUnit(with: .kilo))
        return MassDto(kilograms: kilograms)
    }
}
