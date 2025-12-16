import Foundation
import HealthKit

/// Handler for blood glucose data (instant quantity type)
final class BloodGlucoseHandler:
    HealthKitTypeHandler,
    HealthKitTypeMapper,
    ReadableHealthKitTypeHandler,
    WritableHealthKitTypeHandler,
    UpdatableHealthKitTypeHandler,
    DeletableHealthKitTypeHandler,
    AggregatableHealthKitTypeHandler
{
    /// The HealthKit store for all operations
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static var supportedType: HealthDataTypeDto {
        .bloodGlucose
    }

    typealias RecordDto = BloodGlucoseRecordDto
    typealias SampleType = HKQuantitySample

    /// Convert HealthKit sample to DTO
    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected HKQuantitySample, got \(type(of: sample))"
            )
        }
        guard let dto = quantitySample.toBloodGlucoseRecordDto() else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to convert HKQuantitySample to BloodGlucoseRecordDto"
            )
        }
        return dto
    }

    /// Convert DTO to HealthKit sample
    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let bgDto = dto as? BloodGlucoseRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected BloodGlucoseRecordDto, got \(type(of: dto))"
            )
        }
        return try bgDto.toHealthKit()
    }

    /// Extract timestamp from DTO for pagination
    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let bgDto = dto as? BloodGlucoseRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected BloodGlucoseRecordDto, got \(type(of: dto))"
            )
        }
        return bgDto.time
    }

    /// Get the HKSampleType for queries
    func getSampleType() throws -> HKSampleType {
        try HKQuantityType.safeQuantityType(forIdentifier: .bloodGlucose)
    }

    /// Convert aggregation metric to HKStatisticsOptions
    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        switch metric {
        case .avg:
            return .discreteAverage
        case .min:
            return .discreteMin
        case .max:
            return .discreteMax
        case .sum, .count:
            throw HealthConnectorError.invalidArgument(
                message:
                "Aggregation metric '\(metric)' not supported for blood glucose (discrete data)",
                context: ["details": "Supported metrics: avg, min, max"]
            )
        }
    }

    /// Extract aggregated value from HKStatistics
    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        let quantity: HKQuantity? =
            switch metric {
            case .avg:
                statistics.averageQuantity()
            case .min:
                statistics.minimumQuantity()
            case .max:
                statistics.maximumQuantity()
            case .sum, .count:
                throw HealthConnectorError.invalidArgument(
                    message: "Aggregation metric '\(metric)' not supported for blood glucose",
                    context: ["details": "Supported metrics: avg, min, max"]
                )
            }

        guard let quantity else {
            throw HealthConnectorError.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                context: ["details": "Statistics returned nil for blood glucose"]
            )
        }

        // Uses millimoles per liter as the transfer unit (consistent with mapper)
        return quantity.toBloodGlucoseDto()
    }
}
