import Foundation
import HealthKit

/// Central registry mapping HealthDataTypeDto to type handlers
///
/// This registry provides type-safe dispatch from HealthDataTypeDto to the appropriate handler.
/// Handlers are registered once at initialization and retrieved throughout the app lifecycle.
///
/// **Thread Safety:** Swift's static initialization is thread-safe by default.
/// The `shared` singleton ensures handlers are registered exactly once.
///
/// **Usage Pattern:**
/// ```swift
/// // In HealthConnectorClient.init()
/// _ = HealthKitTypeRegistry.shared  // Trigger registration
///
/// // In methods
/// if let handler = HealthKitTypeRegistry.getSampleHandler(for: request.dataType) {
///     let sample = try handler.toHealthKit(dto)
/// }
/// ```
class HealthKitTypeRegistry {
    // MARK: - Storage

    /// Private storage for registered handlers
    ///
    /// Key: HealthDataTypeDto (enum case)
    /// Value: HealthKitTypeHandler.Type (metatype of handler struct)
    private static var handlers: [HealthDataTypeDto: HealthKitTypeHandler.Type] = [:]

    // MARK: - Registration

    /// Register a handler for a specific health data type
    ///
    /// - Parameter handler: The handler type (metatype) to register
    ///
    /// **Example:**
    /// ```swift
    /// HealthKitTypeRegistry.register(StepsHandler.self)
    /// ```
    ///
    /// **Note:** Handlers are structs, so we register the metatype (`.self`)
    static func register(_ handler: HealthKitTypeHandler.Type) {
        handlers[handler.supportedType] = handler
    }

    // MARK: - Retrieval

    /// Get handler for a specific health data type
    ///
    /// - Parameter type: The HealthDataTypeDto to look up
    /// - Returns: The handler metatype, or nil if not registered
    ///
    /// **Use Case:** Generic handler retrieval (check category after)
    static func getHandler(for type: HealthDataTypeDto) -> HealthKitTypeHandler.Type? {
        return handlers[type]
    }

    /// Get sample handler (for types that use HKSampleQuery)
    ///
    /// - Parameter type: The HealthDataTypeDto to look up
    /// - Returns: The sample handler metatype, or nil if not a sample type
    ///
    /// **Use Case:** CRUD operations (read, write, update, delete)
    ///
    /// **Filters:** Returns nil for characteristic types (they don't support queries)
    static func getSampleHandler(for type: HealthDataTypeDto) -> HealthKitSampleHandler.Type? {
        return handlers[type] as? HealthKitSampleHandler.Type
    }

    /// Get quantity handler (for types that support aggregation)
    ///
    /// - Parameter type: The HealthDataTypeDto to look up
    /// - Returns: The quantity handler metatype, or nil if not a quantity type
    ///
    /// **Use Case:** Aggregation operations (sum, avg, min, max)
    ///
    /// **Filters:** Returns nil for category, correlation, workout, characteristic types
    static func getQuantityHandler(for type: HealthDataTypeDto) -> HealthKitQuantityHandler.Type? {
        return handlers[type] as? HealthKitQuantityHandler.Type
    }

    /// Get correlation handler (for types needing custom delete)
    ///
    /// - Parameter type: The HealthDataTypeDto to look up
    /// - Returns: The correlation handler metatype, or nil if not a correlation
    ///
    /// **Use Case:** Delete operations for blood pressure, food entries
    ///
    /// **Note:** Correlations require special handling - must delete contained samples
    static func getCorrelationHandler(for type: HealthDataTypeDto) -> HealthKitCorrelationHandler.Type? {
        return handlers[type] as? HealthKitCorrelationHandler.Type
    }

    /// Get characteristic handler (for read-only direct API types)
    ///
    /// - Parameter type: The HealthDataTypeDto to look up
    /// - Returns: The characteristic handler metatype, or nil if not a characteristic
    ///
    /// **Use Case:** Reading biological sex, date of birth, blood type
    ///
    /// **Note:** Characteristics cannot be written or deleted
    static func getCharacteristicHandler(for type: HealthDataTypeDto) -> HealthKitCharacteristicHandler.Type? {
        return handlers[type] as? HealthKitCharacteristicHandler.Type
    }

    // MARK: - Initialization

    /// Shared instance that triggers registration
    ///
    /// **Thread Safety:** Swift guarantees static let initialization happens exactly once,
    /// even with concurrent access from multiple threads.
    ///
    /// **Usage:** Access `.shared` to trigger handler registration:
    /// ```swift
    /// _ = HealthKitTypeRegistry.shared
    /// ```
    static let shared: HealthKitTypeRegistry = {
        let registry = HealthKitTypeRegistry()
        registerAllHandlers()
        return registry
    }()

    /// Private initializer to enforce singleton pattern
    private init() {}

    // MARK: - Handler Registration

    /// Register all type handlers
    ///
    /// This method is called once during `shared` initialization.
    /// Add new handlers here as they are implemented.
    ///
    /// **Organization:**
    /// - Quantity types (12 handlers currently implemented)
    /// - Category types (future: sleep analysis, menstrual flow)
    /// - Correlation types (future: blood pressure, food)
    /// - Workout types (future: workout sessions)
    /// - Characteristic types (future: biological sex, date of birth)
    private static func registerAllHandlers() {
        // MARK: Quantity Types

        // Interval records (use endTime for pagination)
        register(StepsHandler.self)
        register(ActiveCaloriesBurnedHandler.self)
        register(DistanceHandler.self)
        register(FloorsClimbedHandler.self)
        register(WheelchairPushesHandler.self)
        register(HydrationHandler.self)

        // Instant records (use time for pagination)
        register(WeightHandler.self)
        register(HeightHandler.self)
        register(BodyFatPercentageHandler.self)
        register(BodyTemperatureHandler.self)  // No aggregation
        register(LeanBodyMassHandler.self)  // No aggregation
        register(HeartRateHandler.self)

        // MARK: Category Types

        register(SleepStageHandler.self)  // ✅ IMPLEMENTED

        // Future category types:
        // register(MenstrualFlowHandler.self)
        // register(SexualActivityHandler.self)

        // MARK: Correlation Types (Future Implementation)

        // Uncomment when implemented:
        // register(BloodPressureHandler.self)
        // register(FoodHandler.self)

        // MARK: Workout Types (Future Implementation)

        // Uncomment when implemented:
        // register(WorkoutHandler.self)

        // MARK: Characteristic Types (Future Implementation)

        // Uncomment when implemented:
        // register(BiologicalSexHandler.self)
        // register(DateOfBirthHandler.self)
        // register(BloodTypeHandler.self)
        // register(FitzpatrickSkinTypeHandler.self)
    }

    // MARK: - Validation (Development Only)

    /// Validate all expected handlers are registered
    ///
    /// **Usage:** Call during development/testing to verify registration
    ///
    /// ```swift
    /// #if DEBUG
    /// HealthKitTypeRegistry.validateRegistration()
    /// #endif
    /// ```
    static func validateRegistration() {
        let expectedTypes: [HealthDataTypeDto] = [
            .steps, .activeCaloriesBurned, .distance, .floorsClimbed,
            .wheelchairPushes, .hydration, .weight, .height,
            .bodyFatPercentage, .bodyTemperature, .leanBodyMass,
            .heartRateMeasurementRecord, .sleepStageRecord
        ]

        HealthConnectorLogger.debug(
            tag: "HealthKitTypeRegistry",
            operation: "validateRegistration",
            phase: "validation",
            message: "Validating handler registration"
        )

        for type in expectedTypes {
            if let handler = getHandler(for: type) {
                HealthConnectorLogger.info(
                    tag: "HealthKitTypeRegistry",
                    operation: "validateRegistration",
                    phase: "success",
                    message: "✅ \(type): category=\(handler.category)"
                )
            } else {
                HealthConnectorLogger.warning(
                    tag: "HealthKitTypeRegistry",
                    operation: "validateRegistration",
                    phase: "missing",
                    message: "❌ Missing handler for: \(type)"
                )
            }
        }
    }

    /// Get count of registered handlers
    ///
    /// **Use Case:** Debugging and testing
    static func registeredHandlerCount() -> Int {
        return handlers.count
    }

    /// Get all registered types
    ///
    /// **Use Case:** Debugging and testing
    static func registeredTypes() -> [HealthDataTypeDto] {
        return Array(handlers.keys)
    }
}
