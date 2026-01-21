import Foundation
import HealthKit

/// Handler for irregular menstrual cycle event data (category type, iOS 16+)
final class IrregularMenstrualCycleEventRecordHandler: @unchecked Sendable,
    ReadableHealthRecordHandler
{
    typealias RecordDto = IrregularMenstrualCycleEventRecordDto
    typealias SampleType = HKCategorySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .irregularMenstrualCycleEvent
}
