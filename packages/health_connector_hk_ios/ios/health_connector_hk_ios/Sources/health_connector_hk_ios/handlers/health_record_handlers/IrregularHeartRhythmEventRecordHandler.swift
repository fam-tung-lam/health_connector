import Foundation
import HealthKit

/// Handler for irregular heart rhythm event data (instant category type)
final class IrregularHeartRhythmEventRecordHandler: @unchecked Sendable,
    ReadableHealthRecordHandler
{
    typealias RecordDto = IrregularHeartRhythmEventRecordDto
    typealias SampleType = HKCategorySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .irregularHeartRhythmEvent
}
