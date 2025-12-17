import Foundation
import HealthKit

/// Handler for sleep stage data (category sample type)
final class SleepStageHandler: @unchecked Sendable,
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler
{
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static var dataType: HealthDataTypeDto {
        .sleepStageRecord
    }
}
