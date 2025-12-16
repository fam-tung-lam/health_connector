import Foundation
import HealthKit

/// Handler for wheelchair pushes data
final class WheelchairPushesHandler:
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
        .wheelchairPushes
    }

    typealias RecordDto = WheelchairPushesRecordDto
    typealias SampleType = HKQuantitySample

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected HKQuantitySample, got \(type(of: sample))"
            )
        }
        guard let dto = quantitySample.toWheelchairPushesRecordDto() else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to convert HKQuantitySample to WheelchairPushesRecordDto"
            )
        }
        return dto
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let pushesDto = dto as? WheelchairPushesRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected WheelchairPushesRecordDto, got \(type(of: dto))"
            )
        }
        return try pushesDto.toHealthKit()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let pushesDto = dto as? WheelchairPushesRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected WheelchairPushesRecordDto, got \(type(of: dto))"
            )
        }
        return pushesDto.endTime
    }

    func getSampleType() throws -> HKSampleType {
        try HKQuantityType.make(from: .pushCount)
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        switch metric {
        case .sum:
            return .cumulativeSum
        case .avg, .min, .max, .count:
            throw HealthConnectorError.invalidArgument(
                message:
                "Aggregation metric '\(metric)' not supported for wheelchair pushes (cumulative data)",
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
                    message: "Aggregation metric '\(metric)' not supported for wheelchair pushes",
                    context: ["details": "Only 'sum' is supported"]
                )
            }

        guard let quantity else {
            throw HealthConnectorError.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                context: ["details": "Statistics returned nil for pushCount"]
            )
        }

        let count = quantity.doubleValue(for: .count())
        return NumericDto(unit: .numeric, value: count)
    }
}
