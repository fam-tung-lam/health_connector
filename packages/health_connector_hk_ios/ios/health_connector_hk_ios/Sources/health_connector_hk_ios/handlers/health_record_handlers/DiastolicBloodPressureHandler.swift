import Foundation
import HealthKit

/// Handler for diastolic blood pressure (instant quantity type)
final class DiastolicBloodPressureHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = DiastolicBloodPressureRecordDto
    typealias SampleType = HKQuantitySample

    /// The HealthKit store for all operations
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static var dataType: HealthDataTypeDto {
        .diastolicBloodPressure
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
                "Aggregation metric '\(metric)' not supported for diastolic blood pressure (discrete data)",
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
                    message:
                    "Aggregation metric '\(metric)' not supported for diastolic blood pressure",
                    context: ["details": "Supported metrics: avg, min, max"]
                )
            }

        guard let quantity else {
            throw HealthConnectorError.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                context: ["details": "Statistics returned nil for bloodPressureDiastolic"]
            )
        }

        return quantity.toPressureDto()
    }
}
