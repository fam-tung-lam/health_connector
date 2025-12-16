import Foundation
import HealthKit

/// Handler for step count data (interval quantity type)
final class StepsHandler:
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
        .steps
    }

    typealias RecordDto = StepRecordDto
    typealias SampleType = HKQuantitySample

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected HKQuantitySample, got \(type(of: sample))"
            )
        }
        guard let dto = quantitySample.toStepRecordDto() else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to convert HKQuantitySample to StepRecordDto"
            )
        }
        return dto
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let stepDto = dto as? StepRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected StepRecordDto, got \(type(of: dto))"
            )
        }
        return try stepDto.toHealthKit()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let stepDto = dto as? StepRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected StepRecordDto, got \(type(of: dto))"
            )
        }
        return stepDto.endTime
    }

    func getSampleType() throws -> HKSampleType {
        try HKQuantityType.make(from: .stepCount)
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        switch metric {
        case .sum:
            return .cumulativeSum
        case .avg, .min, .max, .count:
            throw HealthConnectorError.invalidArgument(
                message: "Aggregation metric '\(metric)' not supported for steps (cumulative data)",
                context: ["details": "Only 'sum' is supported"]
            )
        }
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        let quantity: HKQuantity? =
            switch metric {
            case .sum:
                statistics.sumQuantity()
            case .avg, .min, .max, .count:
                throw HealthConnectorError.invalidArgument(
                    message: "Aggregation metric '\(metric)' not supported for steps",
                    context: ["details": "Only 'sum' is supported"]
                )
            }

        guard let quantity else {
            throw HealthConnectorError.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                context: ["details": "Statistics returned nil for stepCount"]
            )
        }

        let count = quantity.doubleValue(for: .count())
        return NumericDto(unit: .numeric, value: count)
    }
}
