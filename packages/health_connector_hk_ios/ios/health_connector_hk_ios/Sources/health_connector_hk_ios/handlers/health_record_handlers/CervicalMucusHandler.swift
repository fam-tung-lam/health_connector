import Foundation
import HealthKit

/// Handler for cervical mucus health data.
///
/// Supports reading, writing, and deleting cervical mucus observation records.
final class CervicalMucusHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler
{
    typealias RecordDto = CervicalMucusRecordDto
    typealias SampleType = HKCategorySample

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .cervicalMucus
}
