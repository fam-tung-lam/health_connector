import Foundation
import HealthKit

/// Handler for body temperature data (instant quantity type)
final class BodyTemperatureHandler:
    HealthRecordHandler,
    MappableHealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    /// The HealthKit store for all operations
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static var supportedType: HealthDataTypeDto {
        .bodyTemperature
    }

    typealias RecordDto = BodyTemperatureRecordDto
    typealias SampleType = HKQuantitySample

    /// Convert HealthKit sample to DTO
    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected HKQuantitySample, got \(type(of: sample))"
            )
        }
        guard let dto = quantitySample.toBodyTemperatureRecordDto() else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to convert HKQuantitySample to BodyTemperatureRecordDto"
            )
        }
        return dto
    }

    /// Convert DTO to HealthKit sample
    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let temperatureDto = dto as? BodyTemperatureRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected BodyTemperatureRecordDto, got \(type(of: dto))"
            )
        }
        return try temperatureDto.toHealthKit()
    }

    /// Extract timestamp from DTO for pagination
    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let temperatureDto = dto as? BodyTemperatureRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected BodyTemperatureRecordDto, got \(type(of: dto))"
            )
        }
        return temperatureDto.time
    }

    /// Get the HKSampleType for queries
    func getSampleType() throws -> HKSampleType {
        try HKQuantityType.make(from: .bodyTemperature)
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        switch metric {
        case .avg:
            return .discreteAverage
        case .min:
            return .discreteMin
        case .max:
            return .discreteMax
        default:
            throw HealthConnectorError.invalidArgument(
                message: "Aggregation metric '\(metric)' not supported for Body Temperature",
                context: ["details": "Only avg, min, max are supported"]
            )
        }
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        let quantity: HKQuantity? = switch metric {
        case .avg:
            statistics.averageQuantity()
        case .min:
            statistics.minimumQuantity()
        case .max:
            statistics.maximumQuantity()
        default:
            nil
        }

        guard let quantity else {
            throw HealthConnectorError.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                context: ["details": "Statistics returned nil"]
            )
        }
        return quantity.toTemperatureDto()
    }
}
