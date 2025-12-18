import Foundation
import HealthKit

/// Handler for sleep stage data (category sample type)
final class SleepStageHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    CustomAggregatableHealthRecordHandler
{
    typealias RecordDto = SleepStageRecordDto
    typealias SampleType = HKCategorySample

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static var dataType: HealthDataTypeDto {
        .sleepStageRecord
    }
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
    ///   - startTime: Start of time range (milliseconds since epoch)
    ///   - endTime: End of time range (milliseconds since epoch)
    /// - Returns: NumericDto with total sleep duration in seconds
    /// - Throws: HealthConnectorError if query fails or metric is unsupported
    func aggregate(
        metric: AggregationMetricDto,
        startTime: Int64,
        endTime: Int64
    ) async throws -> MeasurementUnitDto {
        try await process(
            operation: "aggregate",
            context: [
                "metric": metric.rawValue,
                "start_time": startTime,
                "end_time": endTime,
            ]
        ) {
            // Validate metric - only sum is supported for sleep stages
            guard metric == .sum else {
                throw HealthConnectorError.invalidArgument(
                    message: "Only sum aggregation is supported for sleep stage records",
                    context: [
                        "details": "Supported metrics: [sum]. Requested: \(metric)",
                    ]
                )
            }

            // Get the sleep analysis category type
            guard let categoryType = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)
            else {
                throw HealthConnectorError.unknown(
                    message: "Failed to create sleep analysis category type"
                )
            }

            // Create time range predicate
            let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000.0)
            let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000.0)
            let predicate = HKQuery.predicateForSamples(
                withStart: startDate,
                end: endDate,
                options: .strictStartDate
            )

            // Query all sleep stage samples in the time range
            let samples = try await withCheckedThrowingContinuation {
                (continuation: CheckedContinuation<[HKCategorySample], Error>) in
                let query = HKSampleQuery(
                    sampleType: categoryType,
                    predicate: predicate,
                    limit: HKObjectQueryNoLimit,
                    sortDescriptors: nil
                ) { _, samples, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let samples else {
                        continuation.resume(returning: [])
                        return
                    }

                    // Filter to only category samples
                    let categorySamples = samples.compactMap {
                        $0 as? HKCategorySample
                    }
                    continuation.resume(returning: categorySamples)
                }

                self.healthStore.execute(query)
            }

            // Calculate total sleep duration
            var totalSleepSeconds: TimeInterval = 0.0

            for sample in samples {
                // Only count actual sleep stages (exclude awake, inBed, outOfBed)
                let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value)

                // Define which stages count as "actual sleep"
                let isActualSleep =
                    switch sleepValue {
                    case .asleep:
                        // Generic sleep (iOS 15 and earlier)
                        true
                    case .awake, .inBed:
                        // Not sleeping
                        false
                    default:
                        // For iOS 16+ detailed stages (core/light, deep, REM)
                        // Check raw values: .core=5, .deep=3, .REM=4
                        if #available(iOS 16.0, *) {
                            switch sample.value {
                            case 3, 4, 5: // deep, REM, core
                                true
                            default:
                                false
                            }
                        } else {
                            false
                        }
                    }

                if isActualSleep {
                    // Calculate duration for this sleep stage
                    let duration = sample.endDate.timeIntervalSince(sample.startDate)
                    totalSleepSeconds += duration
                }
            }

            // Return total sleep time as NumericDto (value in seconds)
            return NumericDto(unit: .numeric, value: totalSleepSeconds)
        }
    }
}
