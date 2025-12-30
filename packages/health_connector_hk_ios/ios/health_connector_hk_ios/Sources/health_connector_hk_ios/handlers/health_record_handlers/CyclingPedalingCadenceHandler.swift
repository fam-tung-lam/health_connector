import Foundation
import HealthKit

/// Handler for cycling pedaling cadence measurement data (instant quantity type)
final class CyclingPedalingCadenceHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = CyclingPedalingCadenceMeasurementRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = NumberDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .cyclingPedalingCadenceMeasurementRecord

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> NumberDto {
        let rpm = quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
        return NumberDto(value: rpm)
    }
}
