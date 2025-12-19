import Foundation
import HealthKit

/// Handler for composite blood pressure samples (correlation type)
final class BloodPressureHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableCorrelationHealthRecordHandler
{
    typealias RecordDto = BloodPressureRecordDto
    typealias SampleType = HKCorrelation

    /// The HealthKit store for all operations
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .bloodPressure
}
