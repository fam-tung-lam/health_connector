import Foundation
import HealthKit

/// Handler for heart rate measurement data (instant quantity type)
final class HeartRateHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = HeartRateRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = NumberDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .heartRateMeasurementRecord

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> NumberDto {
        let bpm = quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
        return NumberDto(value: bpm)
    }
}
