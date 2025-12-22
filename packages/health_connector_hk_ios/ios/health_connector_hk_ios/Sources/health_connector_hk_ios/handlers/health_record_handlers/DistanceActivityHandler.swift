import Foundation
import HealthKit

/// Base class for distance activity handlers.
///
/// Provides common implementation for all activity-specific distance handlers.
/// Each concrete handler specifies its activity type and HealthKit identifier.
///
/// ## Generic Implementation Pattern
///
/// Unlike most other handlers in this codebase, `DistanceActivityHandler` uses a **generic type parameter**
/// to avoid code duplication across similar distance activity types (cycling, swimming, wheelchair, etc.).
///
/// ## Why Computed Properties Instead of Stored Properties?
///
/// **Swift Limitation**: Swift does not support static stored properties in generic types.
///
/// Other handlers in this codebase use the standard pattern:
/// ```swift
/// static let dataType: HealthDataTypeDto = .someType
/// static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]
/// ```
///
/// However, this pattern **does not compile** in generic classes.
// The following would produce a compiler error:
/// ```swift
/// // ❌ ERROR: Static stored properties not supported in generic types
/// static let dataType: HealthDataTypeDto = T.dataType
/// static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]
/// ```
///
/// **Workaround**: Use computed properties (with `var` and curly braces) instead:
/// ```swift
/// // ✅ WORKS: Computed properties are allowed in generic types
/// static var dataType: HealthDataTypeDto { T.dataType }
/// static var supportedAggregationMetrics: Set<AggregationMetricDto> { [.sum] }
/// ```
///
/// This approach provides the same functionality and interface while being compatible with Swift's
/// generic type system. The performance difference is negligible since these are simple property accesses.
class DistanceActivityHandler<T: DistanceActivityHandlerConfig>: Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = DistanceActivityRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = LengthDto

    // HKHealthStore is Sendable, so no @unchecked needed
    nonisolated(unsafe) let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    // Note: These are computed properties (not stored) due to Swift's limitation with
    // static stored properties in generic types. See class documentation for details.
    static var dataType: HealthDataTypeDto {
        T.dataType
    }

    static var activityType: DistanceActivityTypeDto {
        T.activityType
    }

    static var supportedAggregationMetrics: Set<AggregationMetricDto> {
        [.sum]
    }

    func convertQuantity(_ quantity: HKQuantity) throws -> LengthDto {
        let meters = quantity.doubleValue(for: .meter())
        return LengthDto(unit: .meters, value: meters)
    }
}

/// Protocol for distance activity handler configuration
protocol DistanceActivityHandlerConfig {
    static var dataType: HealthDataTypeDto { get }
    static var activityType: DistanceActivityTypeDto { get }
}

// MARK: - Handler Configurations

struct CyclingDistanceHandlerConfig: DistanceActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .cyclingDistance
    static let activityType: DistanceActivityTypeDto = .cycling
}

struct SwimmingDistanceHandlerConfig: DistanceActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .swimmingDistance
    static let activityType: DistanceActivityTypeDto = .swimming
}

struct WheelchairDistanceHandlerConfig: DistanceActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .wheelchairDistance
    static let activityType: DistanceActivityTypeDto = .wheelchair
}

struct WalkingRunningDistanceHandlerConfig: DistanceActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .walkingRunningDistance
    static let activityType: DistanceActivityTypeDto = .walkingRunning
}

struct DownhillSnowSportsDistanceHandlerConfig: DistanceActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .downhillSnowSportsDistance
    static let activityType: DistanceActivityTypeDto = .downhillSnowSports
}

struct RowingDistanceHandlerConfig: DistanceActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .rowingDistance
    static let activityType: DistanceActivityTypeDto = .rowing
}

struct PaddleSportsDistanceHandlerConfig: DistanceActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .paddleSportsDistance
    static let activityType: DistanceActivityTypeDto = .paddleSports
}

struct CrossCountrySkiingDistanceHandlerConfig: DistanceActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .crossCountrySkiingDistance
    static let activityType: DistanceActivityTypeDto = .crossCountrySkiing
}

struct SkatingSportsDistanceHandlerConfig: DistanceActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .skatingSportsDistance
    static let activityType: DistanceActivityTypeDto = .skatingSports
}

struct SixMinuteWalkTestDistanceHandlerConfig: DistanceActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .sixMinuteWalkTestDistance
    static let activityType: DistanceActivityTypeDto = .sixMinuteWalkTest
}

// MARK: - Concrete Handler Type Aliases

typealias CyclingDistanceHandler = DistanceActivityHandler<CyclingDistanceHandlerConfig>
typealias SwimmingDistanceHandler = DistanceActivityHandler<SwimmingDistanceHandlerConfig>
typealias WheelchairDistanceHandler = DistanceActivityHandler<WheelchairDistanceHandlerConfig>
typealias WalkingRunningDistanceHandler = DistanceActivityHandler<
    WalkingRunningDistanceHandlerConfig
>
typealias DownhillSnowSportsDistanceHandler = DistanceActivityHandler<
    DownhillSnowSportsDistanceHandlerConfig
>
typealias RowingDistanceHandler = DistanceActivityHandler<RowingDistanceHandlerConfig>
typealias PaddleSportsDistanceHandler = DistanceActivityHandler<PaddleSportsDistanceHandlerConfig>
typealias CrossCountrySkiingDistanceHandler = DistanceActivityHandler<
    CrossCountrySkiingDistanceHandlerConfig
>
typealias SkatingSportsDistanceHandler = DistanceActivityHandler<SkatingSportsDistanceHandlerConfig>
typealias SixMinuteWalkTestDistanceHandler = DistanceActivityHandler<
    SixMinuteWalkTestDistanceHandlerConfig
>
