import Foundation
import HealthKit

/// Handler for lean body mass data (instant quantity type)
final class LeanBodyMassHandler:
    HealthRecordHandler,
    MappableHealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static var supportedType: HealthDataTypeDto {
        .leanBodyMass
    }

    typealias RecordDto = LeanBodyMassRecordDto
    typealias SampleType = HKQuantitySample

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected HKQuantitySample, got \(type(of: sample))"
            )
        }
        guard let dto = quantitySample.toLeanBodyMassRecordDto() else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to convert HKQuantitySample to LeanBodyMassRecordDto"
            )
        }
        return dto
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let leanMassDto = dto as? LeanBodyMassRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected LeanBodyMassRecordDto, got \(type(of: dto))"
            )
        }
        return try leanMassDto.toHealthKit()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let leanMassDto = dto as? LeanBodyMassRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected LeanBodyMassRecordDto, got \(type(of: dto))"
            )
        }
        return leanMassDto.time
    }

    func getSampleType() throws -> HKSampleType {
        try HKQuantityType.make(from: .leanBodyMass)
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
                message:
                "Aggregation metric '\(metric)' not supported for lean body mass (discrete data)",
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
                    message: "Aggregation metric '\(metric)' not supported for lean body mass",
                    context: ["details": "Supported metrics: avg, min, max"]
                )
            }

        guard let quantity else {
            throw HealthConnectorError.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                context: ["details": "Statistics returned nil for leanBodyMass"]
            )
        }

        let kilograms = quantity.doubleValue(for: .gramUnit(with: .kilo))
        return MassDto(unit: .kilograms, value: kilograms)
    }
}
