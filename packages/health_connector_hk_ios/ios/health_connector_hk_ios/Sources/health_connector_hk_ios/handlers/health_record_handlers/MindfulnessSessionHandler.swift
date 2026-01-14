import Foundation
import HealthKit

/// Handler for mindfulness session data (category sample type).
///
/// ## iOS HealthKit Limitation
///
/// HealthKit only supports a single generic mindfulness type via
/// `HKCategoryTypeIdentifier.mindfulSession`. There is no native support for
/// distinguishing between meditation, breathing, music, movement, or unguided sessions.
///
/// To preserve session type information when writing to HealthKit, this handler stores
/// the session type as custom metadata using the key `health_connector_session_type`.
/// When reading records back, this metadata is used to restore the original session type.
///
/// ## Aggregation
///
/// This handler supports SUM aggregation which returns the total duration of all
/// mindfulness sessions in the specified time range, similar to `SleepStageHandler`.
final class MindfulnessSessionHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    typealias RecordDto = MindfulnessSessionRecordDto
    typealias SampleType = HKCategorySample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .mindfulnessSession

    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]
}

extension MindfulnessSessionHandler {
    /// Performs aggregation for mindfulness session records.
    ///
    /// Since category samples don't support HKStatisticsQuery, we query all mindfulness
    /// session records in the time range and calculate the sum of durations manually.
    ///
    /// **Supported Metrics:**
    /// - `.sum` - Total mindfulness time in seconds across all sessions
    ///
    /// - Parameters:
    ///   - metric: The aggregation metric (only .sum supported)
    ///   - startTime: Start of time range
    ///   - endTime: End of time range
    /// - Returns: TimeDurationDto with total mindfulness duration in seconds
    /// - Throws: HealthConnectorError if query fails or metric is unsupported
    func aggregate(
        metric: AggregationMetricDto,
        startTime: Date,
        endTime: Date
    ) async throws -> Double {
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

            let totalMindfulnessSeconds =
                samples
                    .reduce(0) { $0 + $1.endDate.timeIntervalSince($1.startDate) }

            return totalMindfulnessSeconds
        }
    }
}
