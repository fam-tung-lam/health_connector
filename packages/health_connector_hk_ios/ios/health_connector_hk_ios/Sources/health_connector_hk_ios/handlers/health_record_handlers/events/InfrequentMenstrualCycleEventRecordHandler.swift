import Foundation
import HealthKit

/// Handler for infrequent menstrual cycle event data (category type, iOS 16+)
final class InfrequentMenstrualCycleEventRecordHandler: @unchecked Sendable,
    ReadableHealthRecordHandler
{
    typealias RecordDto = InfrequentMenstrualCycleEventRecordDto
    typealias SampleType = HKCategorySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .infrequentMenstrualCycleEvent
}
