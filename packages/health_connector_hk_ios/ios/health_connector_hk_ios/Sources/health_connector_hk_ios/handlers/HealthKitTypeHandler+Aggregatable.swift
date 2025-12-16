import Foundation
import HealthKit

/// Capability for handlers that support aggregation (quantity types only).
///
/// Only quantity types support aggregation. Category types, correlations, and
/// characteristics do NOT implement this capability.
protocol AggregatableHealthKitTypeHandler: HealthKitTypeHandler {
    /// Get the HKSampleType for aggregation queries
    ///
    /// - Returns: The HKSampleType (must be HKQuantityType) used for this health data type
    /// - Throws: HealthConnectorError if the type cannot be created
    func getSampleType() throws -> HKSampleType

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

extension AggregatableHealthKitTypeHandler {
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
            guard let quantityType = try getSampleType() as? HKQuantityType else {
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
