import Foundation
import HealthKit

/// Handler for headphone audio exposure data (interval discrete quantity type)
final class HeadphoneAudioExposureHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = HeadphoneAudioExposureRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .headphoneAudioExposure

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        let db = quantity.doubleValue(for: .decibelAWeightedSoundPressureLevel())
        return db
    }
}
