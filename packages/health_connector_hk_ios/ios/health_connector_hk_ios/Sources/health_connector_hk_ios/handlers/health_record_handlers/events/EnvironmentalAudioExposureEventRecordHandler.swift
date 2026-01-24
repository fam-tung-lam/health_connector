import Foundation
import HealthKit

/// Handler for environmental audio exposure event data.
final class EnvironmentalAudioExposureEventRecordHandler: @unchecked Sendable,
    ReadableHealthRecordHandler
{
    typealias RecordDto = EnvironmentalAudioExposureEventRecordDto
    typealias SampleType = HKCategorySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .environmentalAudioExposureEvent
}
