import Foundation
import HealthKit

/// Handler for ovulation test data (category sample type)
final class OvulationTestHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler
{
    typealias RecordDto = OvulationTestRecordDto
    typealias SampleType = HKCategorySample

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .ovulationTest
}
