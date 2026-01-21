import Foundation
import HealthKit

/// Handler for low heart rate event data (instant category type)
final class LowHeartRateEventRecordHandler: @unchecked Sendable,
    ReadableHealthRecordHandler
{
    typealias RecordDto = LowHeartRateEventRecordDto
    typealias SampleType = HKCategorySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .lowHeartRateEvent
}
