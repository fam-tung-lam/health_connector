import Foundation
import HealthKit

/// Handler for low cardio fitness event data (instant category type)
final class LowCardioFitnessEventRecordHandler: @unchecked Sendable,
    ReadableHealthRecordHandler
{
    typealias RecordDto = LowCardioFitnessEventRecordDto
    typealias SampleType = HKCategorySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .lowCardioFitnessEvent
}
