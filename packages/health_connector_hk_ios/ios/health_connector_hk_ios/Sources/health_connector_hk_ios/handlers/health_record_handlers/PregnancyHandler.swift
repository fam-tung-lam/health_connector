import Foundation
import HealthKit

/// Handler for pregnancy record data (category sample type)
final class PregnancyHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler
{
    typealias RecordDto = PregnancyRecordDto
    typealias SampleType = HKCategorySample

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .pregnancy
}
