import Foundation
import HealthKit

/// Base class for speed activity handlers.
///
/// Provides common implementation for all activity-specific speed handlers.
/// Each concrete handler specifies its activity type and HealthKit identifier.
///
/// ## Generic Implementation Pattern
///
/// Unlike most other handlers in this codebase, `SpeedActivityHandler` uses a **generic type parameter**
/// to avoid code duplication across similar speed activity types (walking, running, stair ascent, etc.).
///
/// ## Why Computed Properties Instead of Stored Properties?
///
/// Please see [DistanceActivityHandler] class documentation for more details.
class SpeedActivityHandler<T: SpeedActivityHandlerConfig>: Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableQuantityHealthRecordHandler
{
    typealias RecordDto = SpeedActivityRecordDto
    typealias SampleType = HKQuantitySample
    typealias AggregatedResultMeasurementUnitDto = VelocityDto

    // HKHealthStore is Sendable, so no @unchecked needed
    nonisolated(unsafe) let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    // Note: These are computed properties (not stored) due to Swift's limitation with
    // static stored properties in generic types.
    static var dataType: HealthDataTypeDto {
        T.dataType
    }

    static var activityType: SpeedActivityTypeDto {
        T.activityType
    }

    static var supportedAggregationMetrics: Set<AggregationMetricDto> {
        [.avg]
    }

    func convertQuantity(_ quantity: HKQuantity) throws -> VelocityDto {
        let metersPerSecond = quantity.doubleValue(for: HKUnit.meter().unitDivided(by: .second()))
        return VelocityDto(metersPerSecond: metersPerSecond)
    }
}

/// Protocol for speed activity handler configuration
protocol SpeedActivityHandlerConfig {
    static var dataType: HealthDataTypeDto { get }
    static var activityType: SpeedActivityTypeDto { get }
}

// MARK: - Handler Configurations

struct WalkingSpeedHandlerConfig: SpeedActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .walkingSpeed
    static let activityType: SpeedActivityTypeDto = .walking
}

struct RunningSpeedHandlerConfig: SpeedActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .runningSpeed
    static let activityType: SpeedActivityTypeDto = .running
}

struct StairAscentSpeedHandlerConfig: SpeedActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .stairAscentSpeed
    static let activityType: SpeedActivityTypeDto = .stairAscent
}

struct StairDescentSpeedHandlerConfig: SpeedActivityHandlerConfig {
    private init() {
    }

    static let dataType: HealthDataTypeDto = .stairDescentSpeed
    static let activityType: SpeedActivityTypeDto = .stairDescent
}

// MARK: - Concrete Handler Type Aliases

typealias WalkingSpeedHandler = SpeedActivityHandler<WalkingSpeedHandlerConfig>
typealias RunningSpeedHandler = SpeedActivityHandler<RunningSpeedHandlerConfig>
typealias StairAscentSpeedHandler = SpeedActivityHandler<StairAscentSpeedHandlerConfig>
typealias StairDescentSpeedHandler = SpeedActivityHandler<StairDescentSpeedHandlerConfig>
