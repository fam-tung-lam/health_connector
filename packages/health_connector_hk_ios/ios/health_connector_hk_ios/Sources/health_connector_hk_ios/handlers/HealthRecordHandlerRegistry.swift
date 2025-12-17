import Foundation
import HealthKit

/// Central registry mapping `HealthDataTypeDto` to type handlers
///
/// This registry provides type-safe dispatch from `HealthDataTypeDto` to the appropriate handler.
/// Handlers are registered once at initialization and retrieved throughout the app lifecycle.
///
/// Uses `NSLock` to protect the handler dictionary for thread-safe concurrent access.
/// NSLock is used instead of Mutex for iOS 15+ compatibility (Mutex requires iOS 18+).
/// Marked @unchecked Sendable because NSLock-based synchronization ensures thread safety manually.
final class HealthRecordHandlerRegistry: @unchecked Sendable {
    /// Lock for thread-safe access to handlers
    private let lock = NSLock()

    /// Storage for registered handler instances
    ///
    /// Key: `HealthDataTypeDto` (enum case)
    /// Value: Handler instance (any HealthRecordHandler)
    ///
    /// **Thread Safety:** Access protected by NSLock
    private var handlers: [HealthDataTypeDto: any HealthRecordHandler] = [:]

    /// The HealthKit store shared across all handlers
    private let healthStore: HKHealthStore

    /// Initializer
    ///
    /// - Parameter healthStore: The HKHealthStore to inject into all handlers
    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        // Register all handlers (within lock for thread safety)
        lock.lock()
        defer { lock.unlock() }
        registerAllHandlers()
    }

    /// Register a handler instance (called during init only)
    ///
    /// - Parameter handler: The handler instance to register
    ///
    /// **Note:** Must be called within lock
    private func register(_ handler: any HealthRecordHandler) {
        handlers[type(of: handler).dataType] = handler
    }

    /// Get handler for a specific health data type
    ///
    /// Thread-safe: Protected by NSLock
    ///
    /// - Parameter type: The HealthDataTypeDto to look up
    /// - Returns: The handler instance, or nil if not registered
    func getHandler(for type: HealthDataTypeDto) -> (any HealthRecordHandler)? {
        lock.lock()
        defer { lock.unlock() }
        return handlers[type]
    }

    /// Register all type handlers
    ///
    /// This method is called once during initialization.
    /// Add new handlers here as they are implemented.
    ///
    /// **Note:** Must be called within lock
    private func registerAllHandlers() {
        register(StepsHandler(healthStore: healthStore))
        register(ActiveCaloriesBurnedHandler(healthStore: healthStore))
        register(DistanceHandler(healthStore: healthStore))
        register(FloorsClimbedHandler(healthStore: healthStore))
        register(WheelchairPushesHandler(healthStore: healthStore))
        register(HydrationHandler(healthStore: healthStore))
        register(WeightHandler(healthStore: healthStore))
        register(HeightHandler(healthStore: healthStore))
        register(BodyFatPercentageHandler(healthStore: healthStore))
        register(BodyTemperatureHandler(healthStore: healthStore))
        register(LeanBodyMassHandler(healthStore: healthStore))
        register(HeartRateHandler(healthStore: healthStore))
        register(RestingHeartRateHandler(healthStore: healthStore))
        register(SleepStageHandler(healthStore: healthStore))
        register(EnergyNutrientHandler(healthStore: healthStore))
        register(CaffeineNutrientHandler(healthStore: healthStore))
        register(ProteinNutrientHandler(healthStore: healthStore))
        register(TotalCarbohydrateNutrientHandler(healthStore: healthStore))
        register(TotalFatNutrientHandler(healthStore: healthStore))
        register(SaturatedFatNutrientHandler(healthStore: healthStore))
        register(MonounsaturatedFatNutrientHandler(healthStore: healthStore))
        register(PolyunsaturatedFatNutrientHandler(healthStore: healthStore))
        register(CholesterolNutrientHandler(healthStore: healthStore))
        register(DietaryFiberNutrientHandler(healthStore: healthStore))
        register(SugarNutrientHandler(healthStore: healthStore))
        register(VitaminANutrientHandler(healthStore: healthStore))
        register(VitaminB6NutrientHandler(healthStore: healthStore))
        register(VitaminB12NutrientHandler(healthStore: healthStore))
        register(VitaminCNutrientHandler(healthStore: healthStore))
        register(VitaminDNutrientHandler(healthStore: healthStore))
        register(VitaminENutrientHandler(healthStore: healthStore))
        register(VitaminKNutrientHandler(healthStore: healthStore))
        register(ThiaminNutrientHandler(healthStore: healthStore))
        register(RiboflavinNutrientHandler(healthStore: healthStore))
        register(NiacinNutrientHandler(healthStore: healthStore))
        register(FolateNutrientHandler(healthStore: healthStore))
        register(BiotinNutrientHandler(healthStore: healthStore))
        register(PantothenicAcidNutrientHandler(healthStore: healthStore))
        register(CalciumNutrientHandler(healthStore: healthStore))
        register(IronNutrientHandler(healthStore: healthStore))
        register(MagnesiumNutrientHandler(healthStore: healthStore))
        register(ManganeseNutrientHandler(healthStore: healthStore))
        register(PhosphorusNutrientHandler(healthStore: healthStore))
        register(PotassiumNutrientHandler(healthStore: healthStore))
        register(SeleniumNutrientHandler(healthStore: healthStore))
        register(SodiumNutrientHandler(healthStore: healthStore))
        register(ZincNutrientHandler(healthStore: healthStore))
        register(OxygenSaturationHandler(healthStore: healthStore))
        register(RespiratoryRateHandler(healthStore: healthStore))
        register(Vo2MaxHandler(healthStore: healthStore))
        register(BloodGlucoseHandler(healthStore: healthStore))
        register(NutritionCorrelationHandler(healthStore: healthStore))

        register(BloodPressureHandler(healthStore: healthStore))
        register(SystolicBloodPressureHandler(healthStore: healthStore))
        register(DiastolicBloodPressureHandler(healthStore: healthStore))
    }
}
