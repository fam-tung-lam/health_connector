import Foundation
import HealthKit

/// Handler for persistent intermenstrual bleeding event data (category type, iOS 16+)
final class PersistentIntermenstrualBleedingEventRecordHandler: @unchecked Sendable,
    ReadableHealthRecordHandler
{
    typealias RecordDto = PersistentIntermenstrualBleedingEventRecordDto
    typealias SampleType = HKCategorySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .persistentIntermenstrualBleedingEvent
}
