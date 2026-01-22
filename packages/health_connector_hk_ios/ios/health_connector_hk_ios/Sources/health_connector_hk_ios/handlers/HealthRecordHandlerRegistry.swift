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
                message: "Unregistered handler for data type: \(type.rawValue)",
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
        register(ActiveEnergyBurnedHandler(healthStore: healthStore))
        register(BasalEnergyBurnedHandler(healthStore: healthStore))
        register(FloorsClimbedHandler(healthStore: healthStore))
        register(WheelchairPushesHandler(healthStore: healthStore))
        register(ElectrodermalActivityHandler(healthStore: healthStore))
        register(HydrationHandler(healthStore: healthStore))
        register(InsulinDeliveryHandler(healthStore: healthStore))
        register(WeightHandler(healthStore: healthStore))
        register(HeightHandler(healthStore: healthStore))
        register(BodyFatPercentageHandler(healthStore: healthStore))
        register(BodyTemperatureHandler(healthStore: healthStore))
        register(BasalBodyTemperatureHandler(healthStore: healthStore))
        register(SleepingWristTemperatureHandler(healthStore: healthStore))
        register(CervicalMucusHandler(healthStore: healthStore))
        register(LeanBodyMassHandler(healthStore: healthStore))
        register(HeartRateHandler(healthStore: healthStore))
        register(CyclingPedalingCadenceHandler(healthStore: healthStore))
        register(RestingHeartRateHandler(healthStore: healthStore))
        register(WalkingHeartRateAverageHandler(healthStore: healthStore))
        register(SexualActivityHandler(healthStore: healthStore))
        register(SleepStageHandler(healthStore: healthStore))
        register(MindfulnessSessionHandler(healthStore: healthStore))
        register(ExerciseSessionHandler(healthStore: healthStore))
        register(DietaryEnergyConsumedHandler(healthStore: healthStore))
        register(DietaryCaffeineHandler(healthStore: healthStore))
        register(DietaryProteinHandler(healthStore: healthStore))
        register(DietaryTotalCarbohydrateHandler(healthStore: healthStore))
        register(DietaryTotalFatHandler(healthStore: healthStore))
        register(DietarySaturatedFatHandler(healthStore: healthStore))
        register(DietaryMonounsaturatedFatHandler(healthStore: healthStore))
        register(DietaryPolyunsaturatedFatHandler(healthStore: healthStore))
        register(DietaryCholesterolHandler(healthStore: healthStore))
        register(DietaryFiberHandler(healthStore: healthStore))
        register(DietarySugarHandler(healthStore: healthStore))
        register(DietaryVitaminAHandler(healthStore: healthStore))
        register(DietaryVitaminB6Handler(healthStore: healthStore))
        register(DietaryVitaminB12Handler(healthStore: healthStore))
        register(DietaryVitaminCHandler(healthStore: healthStore))
        register(DietaryVitaminDHandler(healthStore: healthStore))
        register(DietaryVitaminEHandler(healthStore: healthStore))
        register(DietaryVitaminKHandler(healthStore: healthStore))
        register(DietaryThiaminHandler(healthStore: healthStore))
        register(DietaryRiboflavinHandler(healthStore: healthStore))
        register(DietaryNiacinHandler(healthStore: healthStore))
        register(DietaryFolateHandler(healthStore: healthStore))
        register(DietaryBiotinHandler(healthStore: healthStore))
        register(DietaryPantothenicAcidHandler(healthStore: healthStore))
        register(DietaryCalciumHandler(healthStore: healthStore))
        register(DietaryIronHandler(healthStore: healthStore))
        register(DietaryMagnesiumHandler(healthStore: healthStore))
        register(DietaryManganeseHandler(healthStore: healthStore))
        register(DietaryPhosphorusHandler(healthStore: healthStore))
        register(DietaryPotassiumHandler(healthStore: healthStore))
        register(DietarySeleniumHandler(healthStore: healthStore))
        register(DietarySodiumHandler(healthStore: healthStore))
        register(DietaryZincHandler(healthStore: healthStore))
        register(OxygenSaturationHandler(healthStore: healthStore))
        register(RespiratoryRateHandler(healthStore: healthStore))
        register(Vo2MaxHandler(healthStore: healthStore))
        register(BloodGlucoseHandler(healthStore: healthStore))
        register(NutritionHandler(healthStore: healthStore))
        register(OvulationTestHandler(healthStore: healthStore))
        register(IntermenstrualBleedingHandler(healthStore: healthStore))
        register(BodyMassIndexHandler(healthStore: healthStore))
        register(MenstrualFlowHandler(healthStore: healthStore))
        register(WaistCircumferenceHandler(healthStore: healthStore))
        register(HeartRateVariabilitySDNNHandler(healthStore: healthStore))
        register(BloodPressureHandler(healthStore: healthStore))
        register(SystolicBloodPressureHandler(healthStore: healthStore))
        register(DiastolicBloodPressureHandler(healthStore: healthStore))
        register(CyclingDistanceHandler(healthStore: healthStore))
        register(CyclingPowerHandler(healthStore: healthStore))
        register(RunningPowerHandler(healthStore: healthStore))
        register(SwimmingDistanceHandler(healthStore: healthStore))
        register(WheelchairDistanceHandler(healthStore: healthStore))
        register(WalkingRunningDistanceHandler(healthStore: healthStore))
        register(DownhillSnowSportsDistanceHandler(healthStore: healthStore))
        register(RowingDistanceHandler(healthStore: healthStore))
        register(PaddleSportsDistanceHandler(healthStore: healthStore))
        register(CrossCountrySkiingDistanceHandler(healthStore: healthStore))
        register(SkatingSportsDistanceHandler(healthStore: healthStore))
        register(SixMinuteWalkTestDistanceHandler(healthStore: healthStore))
        register(WalkingSpeedHandler(healthStore: healthStore))
        register(RunningSpeedHandler(healthStore: healthStore))
        register(StairAscentSpeedHandler(healthStore: healthStore))
        register(StairDescentSpeedHandler(healthStore: healthStore))
        register(PregnancyTestHandler(healthStore: healthStore))
        register(ProgesteroneTestHandler(healthStore: healthStore))
        register(LactationHandler(healthStore: healthStore))
        register(PregnancyHandler(healthStore: healthStore))
        register(ContraceptiveHandler(healthStore: healthStore))
        register(AlcoholicBeveragesHandler(healthStore: healthStore))
        register(ExerciseTimeHandler(healthStore: healthStore))
        register(MoveTimeHandler(healthStore: healthStore))
        register(StandTimeHandler(healthStore: healthStore))
        register(WalkingSteadinessHandler(healthStore: healthStore))
        register(WalkingAsymmetryPercentageHandler(healthStore: healthStore))
        register(WalkingDoubleSupportPercentageHandler(healthStore: healthStore))
        register(WalkingStepLengthHandler(healthStore: healthStore))
        register(SwimmingStrokesHandler(healthStore: healthStore))
        register(BloodAlcoholContentHandler(healthStore: healthStore))
        register(PeripheralPerfusionIndexHandler(healthStore: healthStore))
        register(ForcedVitalCapacityHandler(healthStore: healthStore))
        register(ForcedExpiratoryVolumeHandler(healthStore: healthStore))
        register(HighHeartRateEventRecordHandler(healthStore: healthStore))
        register(IrregularHeartRhythmEventRecordHandler(healthStore: healthStore))
        register(LowHeartRateEventRecordHandler(healthStore: healthStore))
        register(WalkingSteadinessEventRecordHandler(healthStore: healthStore))
        register(InfrequentMenstrualCycleEventRecordHandler(healthStore: healthStore))
        register(IrregularMenstrualCycleEventRecordHandler(healthStore: healthStore))
        register(PersistentIntermenstrualBleedingEventRecordHandler(healthStore: healthStore))
        register(ProlongedMenstrualPeriodEventRecordHandler(healthStore: healthStore))
        register(AtrialFibrillationBurdenHandler(healthStore: healthStore))
        register(NumberOfTimesFallenHandler(healthStore: healthStore))
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
