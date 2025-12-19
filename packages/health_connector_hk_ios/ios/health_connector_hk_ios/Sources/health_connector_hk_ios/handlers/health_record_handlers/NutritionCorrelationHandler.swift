import Foundation
import HealthKit

/// Handler for combined nutrition records using HKCorrelation.food
final class NutritionCorrelationHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableCorrelationHealthRecordHandler
{
    typealias RecordDto = NutritionRecordDto
    typealias SampleType = HKCorrelation

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .nutrition
}
