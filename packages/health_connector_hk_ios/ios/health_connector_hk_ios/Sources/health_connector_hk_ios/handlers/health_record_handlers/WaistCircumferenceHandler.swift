import Foundation
import HealthKit

/// Handler for waist circumference data (instant quantity type)
final class WaistCircumferenceHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = WaistCircumferenceRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = LengthDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .waistCircumference

    // Supports min, max, avg, sum
    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg, .sum]

    func convertQuantity(_ quantity: HKQuantity) throws -> LengthDto {
        let meters = quantity.doubleValue(for: .meter())
        return LengthDto(unit: .meters, value: meters)
    }
}
