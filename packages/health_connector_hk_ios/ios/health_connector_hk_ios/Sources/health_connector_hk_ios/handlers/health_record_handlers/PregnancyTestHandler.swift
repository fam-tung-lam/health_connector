import Foundation
import HealthKit

/// Handler for pregnancy test data (category sample type)
final class PregnancyTestHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler
{
    typealias RecordDto = PregnancyTestRecordDto
    typealias SampleType = HKCategorySample

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .pregnancyTest
}
