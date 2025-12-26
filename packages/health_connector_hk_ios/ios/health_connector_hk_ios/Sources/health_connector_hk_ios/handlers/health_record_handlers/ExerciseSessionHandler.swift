import Foundation
import HealthKit

/// Handler for exercise session data (HKWorkout)
///
/// This handler manages exercise sessions recorded in HealthKit.
/// It supports reading, writing, deleting, and aggregating workout data.
///
/// **Supported Operations:**
/// - Read: Query workout sessions in a date range
/// - Write: Create new workout sessions
/// - Delete: Remove workout sessions by ID
/// - Aggregate: Calculate total duration or count of workouts
///
/// **Aggregation Metrics:**
/// - `.sum`: Total workout duration in seconds across all sessions
/// - `.count`: Number of workout sessions
final class ExerciseSessionHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    typealias RecordDto = ExerciseSessionRecordDto
    typealias SampleType = HKWorkout
    typealias AggregatedResultMeasurementUnitDto = TimeDurationDto

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .exerciseSession

    // Exercise sessions only support sum aggregation (total duration)
    // For counting workouts, use sum with duration as the metric
    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]
}

extension ExerciseSessionHandler {
    /// Performs aggregation for exercise session records.
    ///
    /// Since HKWorkout doesn't support HKStatisticsQuery, we query all workout
    /// sessions in the time range and calculate the sum or count manually.
    ///
    /// **Supported Metrics:**
    /// - `.sum` - Total workout duration in seconds across all sessions
    ///
    /// - Parameters:
    ///   - metric: The aggregation metric (.sum)
    ///   - startTime: Start of time range
    ///   - endTime: End of time range
    /// - Returns: TimeDurationDto with the aggregated value in seconds
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

            let workouts = try await readAllRecords(startTime: startTime, endTime: endTime)

            let result: Double
            switch metric {
            case .sum:
                // Calculate total workout duration in seconds
                result = workouts.reduce(0) { total, workout in
                    total + workout.duration
                }
            default:
                throw HealthConnectorError.unsupportedOperation(
                    message: "Unsupported aggregation metric: \(metric.rawValue)",
                    context: [
                        "metric": metric.rawValue,
                        "supported_metrics": Self.supportedAggregationMetrics.map {
                            String($0.rawValue)
                        }.joined(separator: ", "),
                    ]
                )
            }

            return result.toIntervalDto()
        }
    }
}

// MARK: - HealthKit Type Configuration

extension ExerciseSessionHandler {
    /// Returns the HealthKit workout type
    ///
    /// Exercise sessions use the special HKWorkoutType, not a regular quantity
    /// or category type.
    func healthKitType() throws -> HKObjectType {
        HKObjectType.workoutType()
    }
}
