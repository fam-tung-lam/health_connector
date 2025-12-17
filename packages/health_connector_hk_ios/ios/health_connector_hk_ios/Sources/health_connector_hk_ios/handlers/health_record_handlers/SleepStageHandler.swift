import Foundation
import HealthKit

/// Handler for sleep stage data (category sample type)
final class SleepStageHandler:
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

    static var supportedType: HealthDataTypeDto {
        .sleepStageRecord
    }

    func getSampleType() throws -> HKSampleType {
        try HKCategoryType.make(from: .sleepAnalysis)
    }
}
