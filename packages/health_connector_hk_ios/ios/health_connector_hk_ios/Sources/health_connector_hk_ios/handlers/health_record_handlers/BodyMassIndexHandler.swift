import Foundation
import HealthKit

/// Handler for body mass index data (instant quantity type)
final class BodyMassIndexHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = BodyMassIndexRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = NumberDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .bodyMassIndex

    // Supports min, max, avg, sum
    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg, .sum]

    func convertQuantity(_ quantity: HKQuantity) throws -> NumberDto {
        NumberDto(value: quantity.doubleValue(for: .count()))
    }
}
