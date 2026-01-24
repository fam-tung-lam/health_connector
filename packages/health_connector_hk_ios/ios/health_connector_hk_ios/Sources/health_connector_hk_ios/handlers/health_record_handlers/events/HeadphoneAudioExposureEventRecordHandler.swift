import Foundation
import HealthKit

/// Handler for headphone audio exposure event data.
final class HeadphoneAudioExposureEventRecordHandler: @unchecked Sendable,
    ReadableHealthRecordHandler
{
    typealias RecordDto = HeadphoneAudioExposureEventRecordDto
    typealias SampleType = HKCategorySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .headphoneAudioExposureEvent
}
