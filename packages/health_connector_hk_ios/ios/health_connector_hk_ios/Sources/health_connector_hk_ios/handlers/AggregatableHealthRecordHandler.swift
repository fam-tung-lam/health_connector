import Foundation
import HealthKit

/// Base protocol for handlers that support aggregation capabilities.
///
/// This protocol serves as a marker for all aggregation-capable handlers.
/// Specific implementations are provided by:
/// - `HealthKitAggregatableHealthRecordHandler` for HealthKit quantity types
/// - `CustomAggregatableHealthRecordHandler` for custom aggregation logic
protocol AggregatableHealthRecordHandler: HealthRecordHandler {
}

/// Capability for handlers that support aggregation using HealthKit statistics (quantity types only).
///
/// Only quantity types support aggregation. Category types, correlations, and
/// characteristics do NOT implement this capability.
protocol HealthKitAggregatableHealthRecordHandler: AggregatableHealthRecordHandler {
    /// Convert aggregation metric to HKStatisticsOptions
    ///
    /// - Parameter metric: The aggregation metric requested
    /// - Returns: Corresponding HKStatisticsOptions for the query
    /// - Throws: HealthConnectorError if the metric is not supported
    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions

    /// Extract aggregated value from HKStatistics
    ///
    /// - Parameters:
    ///   - statistics: The HKStatistics result from the query
    ///   - metric: The aggregation metric requested
    /// - Returns: The measurement unit DTO (MassDto, LengthDto, NumericDto, etc.)
    /// - Throws: HealthConnectorError if metric is unsupported or result is null
    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto
}

extension HealthKitAggregatableHealthRecordHandler {
    /// Performs aggregation over a time range
    ///
    /// - Parameters:
    ///   - metric: The aggregation metric to compute
    ///   - startTime: Start of time range (milliseconds since epoch)
    ///   - endTime: End of time range (milliseconds since epoch)
    /// - Returns: The aggregated measurement value
    /// - Throws: HealthConnectorError if aggregation fails
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
            guard let quantityType = try Self.dataType.toHealthKit() as? HKQuantityType else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Aggregation only supported for quantity types"
                )
            }

            let startDate = Date(timeIntervalSince1970: Double(startTime) / 1000.0)
            let endDate = Date(timeIntervalSince1970: Double(endTime) / 1000.0)

            let predicate = HKQuery.predicateForSamples(
                withStart: startDate,
                end: endDate,
                options: [.strictStartDate, .strictEndDate]
            )

            let options = try toStatisticsOptions(metric)

            return try await withCheckedThrowingContinuation { continuation in
                let query = HKStatisticsQuery(
                    quantityType: quantityType,
                    quantitySamplePredicate: predicate,
                    options: options
                ) { _, statistics, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let statistics else {
                        continuation.resume(
                            throwing: HealthConnectorError.invalidArgument(
                                message: "No statistics returned for aggregation"
                            )
                        )
                        return
                    }

                    do {
                        let value = try self.extractAggregateValue(from: statistics, metric: metric)
                        continuation.resume(returning: value)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }

                self.healthStore.execute(query)
            }
        }
    }
}

/// Capability for handlers that support custom aggregation logic.
///
/// For data types that cannot use HKStatisticsQuery (e.g., category samples like sleep stages).
/// This protocol provides a way to implement custom aggregation for data types that don't support
/// standard HKStatisticsQuery-based aggregation.
protocol CustomAggregatableHealthRecordHandler: AggregatableHealthRecordHandler {
    /// Performs custom aggregation over a time range
    ///
    /// - Parameters:
    ///   - metric: The aggregation metric to compute
    ///   - startTime: Start of time range (milliseconds since epoch)
    ///   - endTime: End of time range (milliseconds since epoch)
    /// - Returns: The aggregated measurement value
    /// - Throws: HealthConnectorError if aggregation fails or metric is unsupported
    func aggregate(
        metric: AggregationMetricDto,
        startTime: Int64,
        endTime: Int64
    ) async throws -> MeasurementUnitDto
}
