import Foundation
import HealthKit

/// Handler for prolonged menstrual period event data (category type, iOS 16+)
final class ProlongedMenstrualPeriodEventRecordHandler: @unchecked Sendable,
    ReadableHealthRecordHandler
{
    typealias RecordDto = ProlongedMenstrualPeriodEventRecordDto
    typealias SampleType = HKCategorySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .prolongedMenstrualPeriodEvent
}
