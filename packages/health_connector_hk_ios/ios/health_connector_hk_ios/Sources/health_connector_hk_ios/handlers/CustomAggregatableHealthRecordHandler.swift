import Foundation
import HealthKit

/// Capability for handlers that support custom aggregation logic.
///
/// For data types that cannot use HKStatisticsQuery (e.g., category samples like sleep stages).
/// This protocol provides a way to implement custom aggregation for data types that don't support
/// standard HKStatisticsQuery-based aggregation.
protocol CustomAggregatableHealthRecordHandler: HealthRecordHandler {
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
