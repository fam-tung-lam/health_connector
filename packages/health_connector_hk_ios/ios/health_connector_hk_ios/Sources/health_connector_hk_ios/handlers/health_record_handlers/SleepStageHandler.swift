import Foundation
import HealthKit

/// Handler for sleep stage data (category sample type)
final class SleepStageHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    typealias RecordDto = SleepStageRecordDto
    typealias SampleType = HKCategorySample
    typealias AggregatedResultMeasurementUnitDto = TimeDurationDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .sleepStageRecord

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]
}

extension SleepStageHandler {
    /// Performs aggregation for sleep stage records.
    ///
    /// Since category samples don't support HKStatisticsQuery, we query all sleep
    /// stage records in the time range and calculate the sum of sleep durations manually.
    ///
    /// **Supported Metrics:**
    /// - `.sum` - Total sleep time in seconds across all sleep stages
    ///
    /// **Sleep Stage Filtering:**
    /// Only counts actual sleep stages (excludes awake, inBed, outOfBed states).
    /// Includes: sleeping, light, deep, rem
    ///
    /// - Parameters:
    ///   - metric: The aggregation metric (only .sum supported)
    ///   - startTime: Start of time range
    ///   - endTime: End of time range
    /// - Returns: TimeDurationDto with total sleep duration in seconds
    /// - Throws: HealthConnectorError if query fails or metric is unsupported
    func aggregate(
        metric: AggregationMetricDto,
        startTime: Date,
        endTime: Date
    ) async throws -> TimeDurationDto {
        try await process(
            operation: "aggregate",
            context: [
                "metric": metric.rawValue,
                "start_time": startTime,
                "end_time": endTime,
            ]
        ) {
            try validateAggregationMetric(metric)

            let samples = try await readAllRecords(startTime: startTime, endTime: endTime)

            let totalSleepSeconds =
                samples
                    .filter(isActualSleepStage)
                    .reduce(0) { $0 + $1.endDate.timeIntervalSince($1.startDate) }

            return totalSleepSeconds.toIntervalDto()
        }
    }

    /// Determines if a sleep sample represents actual sleep time.
    ///
    /// - Parameter sample: The sleep analysis category sample
    /// - Returns: `true` if the sample represents actual sleep, `false` otherwise
    ///
    /// **Excluded:** awake, inBed states
    /// **Included:** asleep (iOS 15-), deep/REM/light stages (iOS 16+)
    private func isActualSleepStage(_ sample: HKCategorySample) -> Bool {
        let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value)

        switch sleepValue {
        case .asleep:
            // Generic sleep state (pre-iOS 16)
            return true

        case .awake, .inBed:
            // Not sleeping
            return false

        default:
            // iOS 16+ detailed sleep stages
            if #available(iOS 16.0, *) {
                return [
                    iOS16SleepStage.deep.rawValue,
                    iOS16SleepStage.rem.rawValue,
                    iOS16SleepStage.light.rawValue,
                ].contains(sample.value)
            }
            return false
        }
    }
}
