import Foundation
import HealthKit

/// Handler for environmental audio exposure data (interval discrete quantity type)
final class EnvironmentalAudioExposureHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = EnvironmentalAudioExposureRecordDto
    typealias SampleType = HKQuantitySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .environmentalAudioExposure

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.min, .max, .avg]

    func convertQuantity(_ quantity: HKQuantity) throws -> Double {
        let db = quantity.doubleValue(for: .decibelAWeightedSoundPressureLevel())
        return db
    }
}
