import Foundation
import HealthKit

/// Handler for heart rate measurement data (instant quantity type)
final class HeartRateHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = HeartRateMeasurementRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = NumericDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .heartRateMeasurementRecord

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> NumericDto {
        let bpm = quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
        return NumericDto(unit: .numeric, value: bpm)
    }
}
