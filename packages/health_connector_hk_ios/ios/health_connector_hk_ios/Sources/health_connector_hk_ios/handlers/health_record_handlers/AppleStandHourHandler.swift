import Foundation
import HealthKit

/// Handles read and sum aggregation operations for Apple Stand Hour records.
final class AppleStandHourHandler: @unchecked Sendable {
    typealias RecordDto = AppleStandHourRecordDto
    typealias SampleType = HKCategorySample

    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .appleStandHour
    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]
}

extension AppleStandHourHandler: ReadableHealthRecordHandler {
}

extension AppleStandHourHandler: AggregatableHealthRecordHandler {
}

// MARK: - Aggregation

extension AppleStandHourHandler {
    /// Counts hours in which the user completed the Stand or Roll goal.
    func aggregate(
        metric: AggregationMetricDto,
        startTime: Date,
        endTime: Date
    ) async throws -> Double {
        try await process(
            operation: "aggregate",
            context: [
                "metric": metric.rawValue,
                "query_span_seconds": endTime.timeIntervalSince(startTime),
            ]
        ) {
            try validateAggregationMetric(metric)

            let samples = try await readAllRecords(
                startTime: startTime,
                endTime: endTime
            )

            return Self.countStoodHours(in: samples)
        }
    }

    static func countStoodHours(in samples: [HKCategorySample]) -> Double {
        samples.reduce(0.0) { total, sample in
            total + (sample.value == HKCategoryValueAppleStandHour.stood.rawValue ? 1.0 : 0.0)
        }
    }
}
