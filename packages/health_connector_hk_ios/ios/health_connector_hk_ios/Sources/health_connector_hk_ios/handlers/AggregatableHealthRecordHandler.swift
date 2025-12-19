import Foundation
import HealthKit

/// Base protocol for handlers that support aggregation capabilities.
///
/// This protocol serves as a marker for all aggregation-capable handlers.
///
/// ## Implementation Guidance
/// Conforming types must declare their aggregation result type:
/// ```swift
/// final class HeartRateHandler: AggregatableQuantityHealthRecordHandler {
///     typealias AggregatedResultMeasurementUnitDto = NumericDto  // Required!
///
///     func extractAggregateValue(...) throws -> NumericDto {
///         // Implementation must return declared type
///     }
/// }
/// ```
protocol AggregatableHealthRecordHandler: HealthRecordHandler {
    /// The specific MeasurementUnitDto subtype returned by aggregation
    associatedtype AggregatedResultMeasurementUnitDto: MeasurementUnitDto

    /// Performs aggregation over a time range
    ///
    /// - Parameters:
    ///   - metric: The aggregation metric to compute
    ///   - startTime: Start of time range
    ///   - endTime: End of time range
    /// - Returns: The aggregated measurement value
    /// - Throws: HealthConnectorError if aggregation fails or metric is unsupported
    func aggregate(
        metric: AggregationMetricDto,
        startTime: Date,
        endTime: Date
    ) async throws -> AggregatedResultMeasurementUnitDto
}

/// Configuration for HealthKit statistics query behavior and supported metrics.
///
/// This enum encapsulates the relationship between aggregation metrics,
/// HKStatisticsOptions, and statistics extraction methods. It eliminates
/// repetitive validation logic across handler implementations.
///
/// ## Usage
/// ```swift
/// final class HeartRateHandler: AggregatableQuantityHealthRecordHandler {
///     static let aggregationMetricConfig = AggregationMetricConfig.discreteMinMaxAvg
///
///     func extractAggregateValue(
///         from stats: HKStatistics,
///         metric: AggregationMetricDto
///     ) throws -> NumericDto {
///         let quantity = try Self.aggregationMetricConfig.extractQuantity(from: stats, for: metric)
///         let bpm = quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
///         return NumericDto(unit: .numeric, value: bpm)
///     }
/// }
/// ```
enum AggregationMetricConfig {
    /// Discrete quantity type supporting specified metrics
    /// Examples: Heart rate, weight, body temperature
    case discrete(Set<AggregationMetricDto>)

    /// Cumulative quantity type supporting specified metrics
    /// Examples: Steps, active calories, distance
    case cumulative(Set<AggregationMetricDto>)

    // MARK: - Common Configurations

    /// Discrete type with min, max, avg support (most common for instantaneous measurements)
    static let discreteMinMaxAvg: Self = .discrete([.min, .max, .avg])

    /// Cumulative type with sum support (most common for interval measurements)
    static let cumulativeSum: Self = .cumulative([.sum])

    // MARK: - Public API

    /// Converts an aggregation metric to the appropriate HKStatisticsOptions
    ///
    /// - Parameter metric: The requested aggregation metric
    /// - Returns: The HKStatisticsOptions for the statistics query
    /// - Throws: HealthConnectorError.invalidArgument if metric not supported
    func options(for metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        switch self {
        case let .discrete(supportedMetrics):
            guard supportedMetrics.contains(metric) else {
                throw unsupportedMetricError(
                    metric: metric,
                    supportedMetrics: supportedMetrics,
                    hint: "discrete data"
                )
            }
            return try discreteOption(for: metric)

        case let .cumulative(supportedMetrics):
            guard supportedMetrics.contains(metric) else {
                throw unsupportedMetricError(
                    metric: metric,
                    supportedMetrics: supportedMetrics,
                    hint: "cumulative data"
                )
            }
            return try cumulativeOption(for: metric)
        }
    }

    /// Extracts the quantity value from statistics for a given metric
    ///
    /// - Parameters:
    ///   - statistics: The HKStatistics result from the query
    ///   - metric: The requested aggregation metric
    /// - Returns: The HKQuantity value
    /// - Throws: HealthConnectorError if metric not supported or quantity is nil
    func extractQuantity(
        from statistics: HKStatistics,
        for metric: AggregationMetricDto
    ) throws -> HKQuantity {
        // Validate metric is supported before extracting
        switch self {
        case let .discrete(supportedMetrics):
            guard supportedMetrics.contains(metric) else {
                throw unsupportedMetricError(
                    metric: metric,
                    supportedMetrics: supportedMetrics,
                    hint: "discrete data"
                )
            }
        case let .cumulative(supportedMetrics):
            guard supportedMetrics.contains(metric) else {
                throw unsupportedMetricError(
                    metric: metric,
                    supportedMetrics: supportedMetrics,
                    hint: "cumulative data"
                )
            }
        }

        // Extract quantity based on configuration type
        let quantity: HKQuantity? = switch self {
        case .discrete:
            try extractDiscreteQuantity(from: statistics, metric: metric)
        case .cumulative:
            try extractCumulativeQuantity(from: statistics, metric: metric)
        }

        guard let quantity else {
            throw HealthConnectorError.invalidArgument(
                message: "No aggregation result for metric '\(metric.rawValue)'",
                context: ["details": "Statistics returned nil"]
            )
        }

        return quantity
    }

    // MARK: - Private Helpers

    private func discreteOption(for metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        switch metric {
        case .avg:
            .discreteAverage
        case .min:
            .discreteMin
        case .max:
            .discreteMax
        case .sum, .count:
            // Should never reach here due to guard in options(for:)
            throw HealthConnectorError.invalidArgument(
                message: "Metrics 'sum' and 'count' are not supported for discrete data"
            )
        }
    }

    private func cumulativeOption(for metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        switch metric {
        case .sum:
            .cumulativeSum
        case .avg, .min, .max, .count:
            // Should never reach here due to guard in options(for:)
            throw HealthConnectorError.invalidArgument(
                message: "Only 'sum' is supported for cumulative data"
            )
        }
    }

    private func extractDiscreteQuantity(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> HKQuantity? {
        switch metric {
        case .avg:
            statistics.averageQuantity()
        case .min:
            statistics.minimumQuantity()
        case .max:
            statistics.maximumQuantity()
        case .sum, .count:
            // Should never reach here due to guard in extractQuantity(from:for:)
            throw HealthConnectorError.invalidArgument(
                message: "Metrics 'sum' and 'count' are not supported for discrete data"
            )
        }
    }

    private func extractCumulativeQuantity(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> HKQuantity? {
        switch metric {
        case .sum:
            statistics.sumQuantity()
        case .avg, .min, .max, .count:
            // Should never reach here due to guard in extractQuantity(from:for:)
            throw HealthConnectorError.invalidArgument(
                message: "Only 'sum' is supported for cumulative data"
            )
        }
    }

    private func unsupportedMetricError(
        metric: AggregationMetricDto,
        supportedMetrics: Set<AggregationMetricDto>,
        hint: String? = nil
    ) -> HealthConnectorError {
        let supported = supportedMetrics.map { String($0.rawValue) }.sorted().joined(separator: ", ")
        let message =
            "Aggregation metric '\(metric.rawValue)' not supported\(hint.map { " for \($0)" } ?? "")"
        return HealthConnectorError.invalidArgument(
            message: message,
            context: ["details": "Supported metrics: \(supported)"]
        )
    }
}

/// Capability for handlers that support aggregation using HealthKit statistics (quantity types only).
///
/// Only quantity types support aggregation. Category types, correlations, and
/// characteristics do NOT implement this capability.
protocol AggregatableQuantityHealthRecordHandler: AggregatableHealthRecordHandler {
    /// Statistics configuration defining supported metrics
    ///
    /// This should be set to one of the predefined configurations:
    /// - `.discreteMinMaxAvg` for instantaneous measurements (heart rate, weight, etc.)
    /// - `.cumulativeSum` for interval measurements (steps, calories, etc.)
    static var aggregationMetricConfig: AggregationMetricConfig { get }

    /// Extract aggregated value from HKStatistics
    ///
    /// Uses `aggregationMetricConfig.extractQuantity(from:for:)` to get the HKQuantity,
    /// then delegates to handler for unit conversion to the specific AggregatedResultMeasurementUnitDto type.
    ///
    /// - Parameters:
    ///   - statistics: The HKStatistics result from the query
    ///   - metric: The aggregation metric requested
    /// - Returns: The measurement unit DTO (MassDto, LengthDto, NumericDto, etc.)
    /// - Throws: HealthConnectorError if metric is unsupported or result is null
    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> AggregatedResultMeasurementUnitDto
}

extension AggregatableQuantityHealthRecordHandler {
    /// Performs aggregation over a time range
    ///
    /// - Parameters:
    ///   - metric: The aggregation metric to compute
    ///   - startTime: Start of time range
    ///   - endTime: End of time range
    /// - Returns: The aggregated measurement value
    /// - Throws: HealthConnectorError if aggregation fails
    func aggregate(
        metric: AggregationMetricDto,
        startTime: Date,
        endTime: Date
    ) async throws -> AggregatedResultMeasurementUnitDto {
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

            let predicate = HKQuery.predicateForSamples(
                withStart: startTime,
                end: endTime,
                options: [.strictStartDate, .strictEndDate]
            )

            let options = try Self.aggregationMetricConfig.options(for: metric)

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
