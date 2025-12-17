import Foundation
import HealthKit

/// Handler for respiratory rate data (instant quantity type)
final class RespiratoryRateHandler:
    HealthRecordHandler,
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

    static var dataType: HealthDataTypeDto {
        .respiratoryRate
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
                "Aggregation metric '\(metric)' not supported for respiratory rate (discrete data)",
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
                    message: "Aggregation metric '\(metric)' not supported for respiratory rate",
                    context: ["details": "Supported metrics: avg, min, max"]
                )
            }

        guard let quantity else {
            throw HealthConnectorError.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                context: ["details": "Statistics returned nil for respiratoryRate"]
            )
        }

        let unit = HKUnit.count().unitDivided(by: .minute())
        return NumericDto(unit: .numeric, value: quantity.doubleValue(for: unit))
    }
}
