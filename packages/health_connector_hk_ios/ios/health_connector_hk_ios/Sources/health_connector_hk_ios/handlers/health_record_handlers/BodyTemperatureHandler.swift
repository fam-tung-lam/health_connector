import Foundation
import HealthKit

/// Handler for body temperature data (instant quantity type)
final class BodyTemperatureHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = BodyTemperatureRecordDto
    typealias SampleType = HKQuantitySample

    /// The HealthKit store for all operations
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static var dataType: HealthDataTypeDto {
        .bodyTemperature
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
        let quantity: HKQuantity? =
            switch metric {
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
