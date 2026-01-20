import Foundation
import HealthKit

/// Handler for high heart rate event data (instant category type)
final class HighHeartRateEventRecordHandler: @unchecked Sendable,
    ReadableHealthRecordHandler
{
    typealias RecordDto = HighHeartRateEventRecordDto
    typealias SampleType = HKCategorySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .highHeartRateEvent
}
