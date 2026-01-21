import Foundation
import HealthKit

/// Handler for walking steadiness event data
final class WalkingSteadinessEventRecordHandler: @unchecked Sendable,
    ReadableHealthRecordHandler
{
    typealias RecordDto = WalkingSteadinessEventRecordDto
    typealias SampleType = HKCategorySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .walkingSteadinessEvent
}
