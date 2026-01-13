import Foundation
import HealthKit

// MARK: - Aggregatable Health Record Handler

/// Protocol for health record handlers that support data aggregation.
///
/// Requirements:
/// - Handler must provide a sample type (via `ReadableHealthRecordHandler`)
/// - Handler must support HealthKit statistics queries
protocol AggregatableHealthRecordHandler: HealthRecordHandler {
    /// The type of measurement unit DTO returned by aggregation
    associatedtype AggregatedResultMeasurementUnitDto: MeasurementUnitDto

    /// The aggregation metrics supported by this handler.
    ///
    /// For discrete (instantaneous) types: typically `.min`, `.max`, `.avg`
    /// For cumulative (interval) types: typically `.sum`
    static var supportedAggregationMetrics: Set<AggregationMetricDto> { get }

    /// Aggregates the underlying data for the given date range and metric.
    ///
    /// - Parameters:
    ///   - metric: The aggregation metric to use (min, max, avg, sum)
    ///   - startTime: Start of the data range in UTC
    ///   - endTime: End of the data range in UTC
    /// - Returns: The aggregated result as a measurement DTO
    /// - Throws: `HealthConnectorError` for validation, permissions, or query failures
    func aggregate(
        metric: AggregationMetricDto,
        startTime: Date,
        endTime: Date
    ) async throws -> AggregatedResultMeasurementUnitDto
}

// MARK: - Aggregatable Health Record Handler Helpers

extension AggregatableHealthRecordHandler {
    /// Validates that the requested aggregation metric is supported
    ///
    /// - Parameter metric: The metric to validate
    /// - Throws: HealthConnectorError.invalidArgument if metric is unsupported
    func validateAggregationMetric(_ metric: AggregationMetricDto) throws {
        guard Self.supportedAggregationMetrics.contains(metric) else {
            let supported = Self.supportedAggregationMetrics
                .map { String(describing: $0) }
                .sorted()
                .joined(separator: ", ")

            throw HealthConnectorError.invalidArgument(
                message: "Aggregation metric '\(metric)' not supported by \(Self.dataType)",
                context: ["supported_metrics": supported]
            )
        }
    }
}

// MARK: - Aggregatable Quantity Health Record Handler

/// Protocol for quantity-based health record handlers that support aggregation.
///
/// This protocol provides a default implementation of `aggregate()` that:
/// 1. Validates the requested metric against `supportedAggregationMetrics`
/// 2. Constructs and executes a HealthKit statistics query
/// 3. Extracts the appropriate quantity based on the metric
/// 4. Delegates conversion to the handler's `convertQuantity()` method
protocol AggregatableQuantityHealthRecordHandler: AggregatableHealthRecordHandler,
    ReadableHealthRecordHandler
    where SampleType == HKQuantitySample
{
    /// Converts an HKQuantity to the handler's aggregated result DTO type.
    ///
    /// This is the only conversion method handlers need to implement.
    /// The base protocol handles metric validation and quantity extraction.
    ///
    /// - Parameter quantity: The HealthKit quantity to convert
    /// - Returns: The converted measurement DTO
    /// - Throws: If conversion fails
    func convertQuantity(_ quantity: HKQuantity) throws -> AggregatedResultMeasurementUnitDto
}

// MARK: - Default Aggregate Implementation

extension AggregatableQuantityHealthRecordHandler {
    func aggregate(
        metric: AggregationMetricDto,
        startTime: Date,
        endTime: Date
    ) async throws -> AggregatedResultMeasurementUnitDto {
        let tag = String(describing: type(of: self))
        let operation = "aggregate"
        let querySpanDays =
            Calendar.current.dateComponents([.day], from: startTime, to: endTime).day ?? 0
        let context: [String: Any] = [
            "data_type": Self.dataType.rawValue,
            "metric": String(describing: metric),
            "query_span_days": querySpanDays,
        ]

        HealthConnectorLogger.debug(
            tag: tag,
            operation: operation,
            message: "Preparing aggregation",
            context: context
        )

        // Validate the requested metric is supported
        try validateAggregationMetric(metric)

        // Get the HKStatisticsOptions for this metric
        let options = try statisticsOptions(for: metric)

        // Lookup the HKQuantityType for this handler
        guard let quantityType = try Self.dataType.toHealthKit() as? HKQuantityType else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Data type \(Self.dataType) does not support quantity-based aggregation",
                context: context.merging([
                    "data_type": String(describing: Self.dataType),
                ]) { _, new in new }
            )
        }

        // Construct the predicate
        let predicate = HKQuery.predicateForSamples(
            withStart: startTime,
            end: endTime,
            options: [.strictStartDate, .strictEndDate]
        )

        // Execute the statistics query using async/await wrapper
        let statistics: HKStatistics = try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsQuery(
                quantityType: quantityType,
                quantitySamplePredicate: predicate,
                options: options
            ) { _, statistics, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let statistics {
                    continuation.resume(returning: statistics)
                } else {
                    continuation.resume(
                        throwing: HealthConnectorError.unknownError(
                            message:
                            "No aggregation data available for \(Self.dataType) in the specified time range",
                            context: context.merging([
                                "data_type": String(describing: Self.dataType),
                                "metric": String(describing: metric),
                                "start_time": String(describing: startTime),
                                "end_time": String(describing: endTime),
                            ]) { _, new in new }
                        )
                    )
                }
            }

            healthStore.execute(query)
        }

        // Extract the quantity for the requested metric
        let quantity = try extractQuantity(from: statistics, for: metric)

        // Convert to the handler's DTO type
        let result = try convertQuantity(quantity)

        HealthConnectorLogger.info(
            tag: tag,
            operation: operation,
            message: "Aggregation completed",
            context: context
        )

        return result
    }
}

// MARK: - Private Helper Methods

extension AggregatableQuantityHealthRecordHandler {
    /// Returns the appropriate HKStatisticsOptions for the given aggregation metric.
    ///
    /// - Parameter metric: The aggregation metric
    /// - Returns: The corresponding HKStatisticsOptions
    /// - Throws: `HealthConnectorError.invalidArgument` for unsupported metrics
    private func statisticsOptions(for metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        switch metric {
        case .min:
            .discreteMin
        case .max:
            .discreteMax
        case .avg:
            .discreteAverage
        case .sum:
            .cumulativeSum
        }
    }

    /// Extracts the appropriate HKQuantity from statistics based on the metric.
    ///
    /// - Parameters:
    ///   - statistics: The HKStatistics result from the query
    ///   - metric: The aggregation metric being requested
    /// - Returns: The extracted HKQuantity
    /// - Throws: `HealthConnectorError.unknown` if the quantity is nil
    private func extractQuantity(
        from statistics: HKStatistics,
        for metric: AggregationMetricDto
    ) throws -> HKQuantity {
        let quantity: HKQuantity? =
            switch metric {
            case .min:
                statistics.minimumQuantity()
            case .max:
                statistics.maximumQuantity()
            case .avg:
                statistics.averageQuantity()
            case .sum:
                statistics.sumQuantity()
            }

        guard let quantity else {
            throw HealthConnectorError.unknownError(
                message: "No quantity data available for metric '\(metric)' on \(Self.dataType)",
                context: [
                    "data_type": String(describing: Self.dataType),
                    "metric": String(describing: metric),
                ]
            )
        }

        return quantity
    }
}
