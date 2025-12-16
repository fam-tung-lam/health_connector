import Foundation
import HealthKit

/// Handler for weight data (instant quantity type)
final class WeightHandler:
    HealthKitTypeHandler,
    HealthKitTypeMapper,
    ReadableHealthKitTypeHandler,
    WritableHealthKitTypeHandler,
    UpdatableHealthKitTypeHandler,
    DeletableHealthKitTypeHandler,
    AggregatableHealthKitTypeHandler
{
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static var supportedType: HealthDataTypeDto {
        .weight
    }

    static var category: HealthKitDataCategory {
        .quantitySample
    }

    typealias RecordDto = WeightRecordDto
    typealias SampleType = HKQuantitySample

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected HKQuantitySample, got \(type(of: sample))"
            )
        }
        guard let dto = quantitySample.toWeightRecordDto() else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to convert HKQuantitySample to WeightRecordDto"
            )
        }
        return dto
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let weightDto = dto as? WeightRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected WeightRecordDto, got \(type(of: dto))"
            )
        }
        return try weightDto.toHealthKit()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let weightDto = dto as? WeightRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected WeightRecordDto, got \(type(of: dto))"
            )
        }
        return weightDto.time
    }

    func getSampleType() throws -> HKSampleType {
        try HKQuantityType.safeQuantityType(forIdentifier: .bodyMass)
    }

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
                message: "Aggregation metric '\(metric)' not supported for weight (discrete data)",
                context: ["details": "Supported metrics: avg, min, max"]
            )
        }
    }

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
                    message: "Aggregation metric '\(metric)' not supported for weight",
                    context: ["details": "Supported metrics: avg, min, max"]
                )
            }

        guard let quantity else {
            throw HealthConnectorError.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                context: ["details": "Statistics returned nil for bodyMass"]
            )
        }

        let kilograms = quantity.doubleValue(for: .gramUnit(with: .kilo))
        return MassDto(unit: .kilograms, value: kilograms)
    }
}
