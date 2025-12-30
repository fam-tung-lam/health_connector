import Foundation
import HealthKit

/// Central registry mapping `HealthDataTypeDto` to type handlers
///
/// Uses `NSLock` to protect the handler dictionary for thread-safe concurrent initialization.
/// NSLock is used instead of Mutex for iOS 15+ compatibility (Mutex requires iOS 18+).
/// Marked @unchecked Sendable because NSLock-based synchronization ensures thread safety manually.
final class HealthRecordHandlerRegistry: @unchecked Sendable {
    /// Lock for thread-safe registry initialization
    private let initLock = NSLock()

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

        // Register all handlers (within initLock for thread safety)
        initLock.lock()
        defer { initLock.unlock() }

        registerAllHandlers()
    }

    /// Gets a handler with a specific capability (type-safe retrieval)
    ///
    /// - Parameters:
    ///   - type: The HealthDataTypeDto to look up
    ///   - capability: The protocol type the handler must conform to
    /// - Returns: The handler instance conforming to the capability
    /// - Throws: HealthConnectorError.unsupportedOperation if handler not found or lacks capability
    ///
    /// ## Example
    /// ```swift
    /// let handler = try registry.handler(for: .steps, withCapability: ReadableHealthRecordHandler.self)
    /// ```
    func handler<T>(
        for type: HealthDataTypeDto,
        withCapability capability: T.Type
    ) throws -> T {
        guard let baseHandler = handlers[type] else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Unsupported data type: \(type.rawValue)",
                context: ["dataType": type.rawValue]
            )
        }

        guard let handler = baseHandler as? T else {
            throw HealthConnectorError.unsupportedOperation(
                message:
                "Data type \(type.rawValue) does not support \(String(describing: capability))",
                context: [
                    "dataType": type.rawValue,
                    "capability": String(describing: capability),
                ]
            )
        }

        return handler
    }

    /// Register all type handlers
    ///
    /// This method is called once during initialization.
    /// Add new handlers here as they are implemented.
    ///
    /// **Note:** Must be called within initLock
    private func registerAllHandlers() {
        register(StepsHandler(healthStore: healthStore))
        register(ActiveCaloriesBurnedHandler(healthStore: healthStore))
        register(FloorsClimbedHandler(healthStore: healthStore))
        register(WheelchairPushesHandler(healthStore: healthStore))
        register(HydrationHandler(healthStore: healthStore))
        register(WeightHandler(healthStore: healthStore))
        register(HeightHandler(healthStore: healthStore))
        register(BodyFatPercentageHandler(healthStore: healthStore))
        register(BodyTemperatureHandler(healthStore: healthStore))
        register(CervicalMucusHandler(healthStore: healthStore))
        register(LeanBodyMassHandler(healthStore: healthStore))
        register(HeartRateHandler(healthStore: healthStore))
        register(CyclingPedalingCadenceHandler(healthStore: healthStore))
        register(RestingHeartRateHandler(healthStore: healthStore))
        register(SexualActivityHandler(healthStore: healthStore))
        register(SleepStageHandler(healthStore: healthStore))
        register(MindfulnessSessionHandler(healthStore: healthStore))
        register(ExerciseSessionHandler(healthStore: healthStore))
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
        register(NutritionHandler(healthStore: healthStore))
        register(OvulationTestHandler(healthStore: healthStore))
        register(BloodPressureHandler(healthStore: healthStore))
        register(SystolicBloodPressureHandler(healthStore: healthStore))
        register(DiastolicBloodPressureHandler(healthStore: healthStore))
        // Distance activity handlers (iOS HealthKit only)
        register(CyclingDistanceHandler(healthStore: healthStore))
        register(CyclingPowerHandler(healthStore: healthStore))
        register(SwimmingDistanceHandler(healthStore: healthStore))
        register(WheelchairDistanceHandler(healthStore: healthStore))
        register(WalkingRunningDistanceHandler(healthStore: healthStore))
        register(DownhillSnowSportsDistanceHandler(healthStore: healthStore))
        register(RowingDistanceHandler(healthStore: healthStore))
        register(PaddleSportsDistanceHandler(healthStore: healthStore))
        register(CrossCountrySkiingDistanceHandler(healthStore: healthStore))
        register(SkatingSportsDistanceHandler(healthStore: healthStore))
        register(SixMinuteWalkTestDistanceHandler(healthStore: healthStore))
        // Speed activity handlers (iOS HealthKit only)
        register(WalkingSpeedHandler(healthStore: healthStore))
        register(RunningSpeedHandler(healthStore: healthStore))
        register(StairAscentSpeedHandler(healthStore: healthStore))
        register(StairDescentSpeedHandler(healthStore: healthStore))
    }

    /// Register a handler instance (called during init only)
    ///
    /// - Parameter handler: The handler instance to register
    ///
    /// **Note:** Must be called within initLock
    private func register(_ handler: any HealthRecordHandler) {
        handlers[type(of: handler).dataType] = handler
    }
}
