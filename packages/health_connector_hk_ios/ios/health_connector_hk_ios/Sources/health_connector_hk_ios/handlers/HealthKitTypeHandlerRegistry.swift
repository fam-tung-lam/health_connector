import Foundation
import HealthKit

/**
 * Central registry mapping `HealthDataTypeDto` to type handlers
 *
 * This registry provides type-safe dispatch from `HealthDataTypeDto` to the appropriate handler.
 * Handlers are registered once at initialization and retrieved throughout the app lifecycle.
 */
class HealthKitTypeRegistry {
    /**
     * Private storage for registered handlers
     *
     * Key: `HealthDataTypeDto` (enum case)
     * Value: `HealthKitTypeHandler.Type` (metatype of handler struct)
     */
    private static var handlers: [HealthDataTypeDto: HealthKitTypeHandler.Type] = [:]

    /**
     * Register a handler for a specific health data type
     *
     * - Parameter handler: The handler type (metatype) to register
     *
     * **Note:** Handlers are structs, so we register the metatype (`.self`)
     */
    static func register(_ handler: HealthKitTypeHandler.Type) {
        handlers[handler.supportedType] = handler
    }

    /**
     * Get handler for a specific health data type
     *
     * - Parameter type: The HealthDataTypeDto to look up
     * - Returns: The handler metatype, or nil if not registered
     *
     * **Use Case:** Generic handler retrieval (check category after)
     */
    static func getHandler(for type: HealthDataTypeDto) -> HealthKitTypeHandler.Type? {
        handlers[type]
    }

    /**
     * Get sample handler (for types that use HKSampleQuery)
     *
     * - Parameter type: The HealthDataTypeDto to look up
     * - Returns: The sample handler metatype, or nil if not a sample type
     *
     * **Use Case:** CRUD operations (read, write, update, delete)
     *
     * **Filters:** Returns nil for characteristic types (they don't support queries)
     */
    static func getSampleHandler(for type: HealthDataTypeDto) -> HealthKitSampleHandler.Type? {
        handlers[type] as? HealthKitSampleHandler.Type
    }

    /**
     * Get quantity handler (for types that support aggregation)
     *
     * - Parameter type: The HealthDataTypeDto to look up
     * - Returns: The quantity handler metatype, or nil if not a quantity type
     *
     * **Use Case:** Aggregation operations (sum, avg, min, max)
     *
     * **Filters:** Returns nil for category, correlation, workout, characteristic types
     */
    static func getQuantityHandler(for type: HealthDataTypeDto) -> HealthKitQuantityHandler.Type? {
        handlers[type] as? HealthKitQuantityHandler.Type
    }

    /**
     * Get correlation handler (for types needing custom delete)
     *
     * - Parameter type: The HealthDataTypeDto to look up
     * - Returns: The correlation handler metatype, or nil if not a correlation
     *
     * **Use Case:** Delete operations for blood pressure, food entries
     *
     * **Note:** Correlations require special handling - must delete contained samples
     */
    static func getCorrelationHandler(for type: HealthDataTypeDto) -> HealthKitCorrelationHandler.Type? {
        handlers[type] as? HealthKitCorrelationHandler.Type
    }

    /**
     * Get characteristic handler (for read-only direct API types)
     *
     * - Parameter type: The HealthDataTypeDto to look up
     * - Returns: The characteristic handler metatype, or nil if not a characteristic
     *
     * **Use Case:** Reading biological sex, date of birth, blood type
     *
     * **Note:** Characteristics cannot be written or deleted
     */
    static func getCharacteristicHandler(for type: HealthDataTypeDto) -> HealthKitCharacteristicHandler.Type? {
        handlers[type] as? HealthKitCharacteristicHandler.Type
    }

    /**
     * Shared instance that triggers registration
     *
     * **Thread Safety:** Swift guarantees static let initialization happens exactly once,
     * even with concurrent access from multiple threads.
     */
    static let shared: HealthKitTypeRegistry = {
        let registry = HealthKitTypeRegistry()
        registerAllHandlers()
        return registry
    }()

    // Private initializer to enforce singleton pattern
    private init() {
    }

    /**
     * Register all type handlers
     *
     * This method is called once during `shared` initialization.
     * Add new handlers here as they are implemented.
     */
    private static func registerAllHandlers() {
        register(StepsHandler.self)
        register(ActiveCaloriesBurnedHandler.self)
        register(DistanceHandler.self)
        register(FloorsClimbedHandler.self)
        register(WheelchairPushesHandler.self)
        register(HydrationHandler.self)
        register(WeightHandler.self)
        register(HeightHandler.self)
        register(BodyFatPercentageHandler.self)
        register(BodyTemperatureHandler.self)
        register(LeanBodyMassHandler.self)
        register(HeartRateHandler.self)
        register(RestingHeartRateHandler.self)
        register(SleepStageHandler.self)
        register(EnergyNutrientHandler.self)
        register(CaffeineNutrientHandler.self)
        register(ProteinNutrientHandler.self)
        register(TotalCarbohydrateNutrientHandler.self)
        register(TotalFatNutrientHandler.self)
        register(SaturatedFatNutrientHandler.self)
        register(MonounsaturatedFatNutrientHandler.self)
        register(PolyunsaturatedFatNutrientHandler.self)
        register(CholesterolNutrientHandler.self)
        register(DietaryFiberNutrientHandler.self)
        register(SugarNutrientHandler.self)
        register(VitaminANutrientHandler.self)
        register(VitaminB6NutrientHandler.self)
        register(VitaminB12NutrientHandler.self)
        register(VitaminCNutrientHandler.self)
        register(VitaminDNutrientHandler.self)
        register(VitaminENutrientHandler.self)
        register(VitaminKNutrientHandler.self)
        register(ThiaminNutrientHandler.self)
        register(RiboflavinNutrientHandler.self)
        register(NiacinNutrientHandler.self)
        register(FolateNutrientHandler.self)
        register(BiotinNutrientHandler.self)
        register(PantothenicAcidNutrientHandler.self)
        register(CalciumNutrientHandler.self)
        register(IronNutrientHandler.self)
        register(MagnesiumNutrientHandler.self)
        register(ManganeseNutrientHandler.self)
        register(PhosphorusNutrientHandler.self)
        register(PotassiumNutrientHandler.self)
        register(SeleniumNutrientHandler.self)
        register(SodiumNutrientHandler.self)
        register(ZincNutrientHandler.self)
        register(OxygenSaturationHandler.self)
        register(RespiratoryRateHandler.self)
        register(NutritionCorrelationHandler.self)
        register(BloodPressureHandler.self)
        register(SystolicBloodPressureHandler.self)
        register(DiastolicBloodPressureHandler.self)
    }
}
