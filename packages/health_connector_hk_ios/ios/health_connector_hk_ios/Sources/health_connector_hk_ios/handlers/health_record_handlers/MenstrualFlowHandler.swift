import Foundation
import HealthKit

/// Handler for menstrual flow data (category sample type)
final class MenstrualFlowHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler
{
    typealias RecordDto = MenstrualFlowRecordDto
    typealias SampleType = HKCategorySample

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .menstrualFlow
}
