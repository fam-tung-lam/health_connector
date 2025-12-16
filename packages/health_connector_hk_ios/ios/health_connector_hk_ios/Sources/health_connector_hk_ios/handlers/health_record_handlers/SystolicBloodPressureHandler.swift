import Foundation
import HealthKit

/// Handler for systolic blood pressure (instant quantity type)
final class SystolicBloodPressureHandler:
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
        .systolicBloodPressure
    }

    typealias RecordDto = SystolicBloodPressureRecordDto
    typealias SampleType = HKQuantitySample

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected HKQuantitySample, got \(type(of: sample))"
            )
        }
        guard let dto = quantitySample.toSystolicBloodPressureRecordDto() else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to convert HKQuantitySample to SystolicBloodPressureRecordDto"
            )
        }
        return dto
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let systolicDto = dto as? SystolicBloodPressureRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected SystolicBloodPressureRecordDto, got \(type(of: dto))"
            )
        }
        return try systolicDto.toHealthKit()
    }

    func getSampleType() throws -> HKSampleType {
        try HKQuantityType.make(from: .bloodPressureSystolic)
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
                "Aggregation metric '\(metric)' not supported for systolic blood pressure (discrete data)",
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
                    message:
                    "Aggregation metric '\(metric)' not supported for systolic blood pressure",
                    context: ["details": "Supported metrics: avg, min, max"]
                )
            }

        guard let quantity else {
            throw HealthConnectorError.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                context: ["details": "Statistics returned nil for bloodPressureSystolic"]
            )
        }

        return quantity.toPressureDto()
    }
}
