import Foundation
import HealthKit

/// Handler for hydration/water intake data (interval quantity type)
final class HydrationHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = HydrationRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = VolumeDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .hydration

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]

    func convertQuantity(_ quantity: HKQuantity) throws -> VolumeDto {
        let liters = quantity.doubleValue(for: .liter())
        return VolumeDto(liters: liters)
    }
}
