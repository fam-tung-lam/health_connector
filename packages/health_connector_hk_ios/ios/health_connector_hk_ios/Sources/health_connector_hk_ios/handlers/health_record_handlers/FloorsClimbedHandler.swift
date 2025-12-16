import Foundation
import HealthKit

/// Handler for floors climbed data (interval quantity type)
final class FloorsClimbedHandler:
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
        .floorsClimbed
    }

    typealias RecordDto = FloorsClimbedRecordDto
    typealias SampleType = HKQuantitySample

    /// Convert HealthKit sample to DTO
    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected HKQuantitySample, got \(type(of: sample))"
            )
        }
        guard let dto = quantitySample.toFloorsClimbedRecordDto() else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to convert HKQuantitySample to FloorsClimbedRecordDto"
            )
        }
        return dto
    }

    /// Convert DTO to HealthKit sample
    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let floorsDto = dto as? FloorsClimbedRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected FloorsClimbedRecordDto, got \(type(of: dto))"
            )
        }
        return try floorsDto.toHealthKit()
    }

    /// Get the HKSampleType for queries
    func getSampleType() throws -> HKSampleType {
        try HKQuantityType.make(from: .flightsClimbed)
    }

    /// Convert aggregation metric to HKStatisticsOptions
    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        switch metric {
        case .sum:
            return .cumulativeSum
        case .avg, .min, .max, .count:
            throw HealthConnectorError.invalidArgument(
                message:
                "Aggregation metric '\(metric)' not supported for floors climbed (cumulative data)",
                context: ["details": "Only 'sum' is supported"]
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
            case .sum:
                statistics.sumQuantity()
            case .avg, .min, .max, .count:
                throw HealthConnectorError.invalidArgument(
                    message: "Aggregation metric '\(metric)' not supported for floors climbed",
                    context: ["details": "Only 'sum' is supported"]
                )
            }

        guard let quantity else {
            throw HealthConnectorError.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                context: ["details": "Statistics returned nil for flightsClimbed"]
            )
        }

        let count = quantity.doubleValue(for: .count())
        return NumericDto(unit: .numeric, value: count)
    }
}
