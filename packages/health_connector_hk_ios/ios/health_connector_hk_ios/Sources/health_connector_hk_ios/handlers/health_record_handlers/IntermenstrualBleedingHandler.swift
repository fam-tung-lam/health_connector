import Foundation
import HealthKit

/// Handler for intermenstrual bleeding data (category sample type)
final class IntermenstrualBleedingHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler
{
    typealias RecordDto = IntermenstrualBleedingRecordDto
    typealias SampleType = HKCategorySample

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .intermenstrualBleeding
}
