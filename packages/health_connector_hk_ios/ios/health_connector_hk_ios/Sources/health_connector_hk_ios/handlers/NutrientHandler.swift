import Foundation
import HealthKit

/// Unified handler for all individual nutrient types.
///
/// **Note:** This struct does not directly conform to HealthKitQuantityHandler because
/// it uses instance methods. The wrapper structs (e.g., EnergyNutrientHandler) provide
/// the static protocol conformance by delegating to instance methods of NutrientHandler.
struct NutrientHandler {
    // MARK: - Properties

    /// The specific nutrient type this handler instance supports
    private let nutrientType: HealthDataTypeDto

    /// The HealthKit quantity type identifier for this nutrient
    private let quantityTypeIdentifier: HKQuantityTypeIdentifier

    // MARK: - Initialization

    /**
     * Creates a nutrient handler for a specific nutrient type.
     *
     * - Parameters:
     *   - nutrientType: The HealthDataTypeDto for the nutrient
     *   - quantityTypeIdentifier: The corresponding HealthKit quantity type identifier
     */
    init(nutrientType: HealthDataTypeDto, quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        self.nutrientType = nutrientType
        self.quantityTypeIdentifier = quantityTypeIdentifier
    }

    // MARK: - HealthKitTypeHandler

    static var supportedType: HealthDataTypeDto {
        // This will be overridden by each instance via the instance method
        fatalError("Use instance property instead")
    }

    var instanceSupportedType: HealthDataTypeDto {
        return nutrientType
    }

    static var category: HealthKitDataCategory {
        return .quantitySample
    }

    // MARK: - HealthKitSampleHandler

    func toDTO(_ sample: HKSample) throws -> HealthRecordDto? {
        // Type guard: Verify this is a quantity sample
        guard let quantitySample = sample as? HKQuantitySample else {
            return nil
        }

        // Verify this is the correct nutrient type
        guard quantitySample.quantityType.identifier == quantityTypeIdentifier.rawValue else {
            return nil
        }

        // Delegate to the appropriate nutrient-specific mapper
        return quantitySample.toNutrientDto(for: nutrientType)
    }

    func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        // Delegate to the nutrient-specific mapper extension
        return try dto.toHealthKitNutrientSample(for: nutrientType, quantityTypeIdentifier: quantityTypeIdentifier)
    }

    func getSampleType() -> HKSampleType {
        return HKQuantityType.quantityType(forIdentifier: quantityTypeIdentifier)!
    }

    func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        // All nutrients are instant records with a 'time' field
        return dto.extractNutrientTime()
    }

    // MARK: - HealthKitQuantityHandler (Aggregation Support)

    func supportedAggregations() -> [AggregationMetricDto] {
        // All nutrients support sum aggregation (total consumed over time)
        return [.sum]
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions {
        switch metric {
        case .sum:
            // Cumulative sum for total nutrients consumed
            return .cumulativeSum
        default:
            // Other metrics don't make sense for nutrients
            return []
        }
    }

    // MARK: - Factory Methods

    /**
     * Creates nutrient handler instances for all nutrient types.
     *
     * This factory method returns an array of configured handler instances,
     * one for each supported nutrient type.
     *
     * - Returns: Array of NutrientHandler instances
     */
    static func createAllNutrientHandlers() -> [NutrientHandler] {
        return [
            NutrientHandler(nutrientType: .energyNutrient, quantityTypeIdentifier: .dietaryEnergyConsumed),
            NutrientHandler(nutrientType: .caffeine, quantityTypeIdentifier: .dietaryCaffeine),
            NutrientHandler(nutrientType: .protein, quantityTypeIdentifier: .dietaryProtein),
            NutrientHandler(nutrientType: .totalCarbohydrate, quantityTypeIdentifier: .dietaryCarbohydrates),
            NutrientHandler(nutrientType: .totalFat, quantityTypeIdentifier: .dietaryFatTotal),
            NutrientHandler(nutrientType: .saturatedFat, quantityTypeIdentifier: .dietaryFatSaturated),
            NutrientHandler(nutrientType: .monounsaturatedFat, quantityTypeIdentifier: .dietaryFatMonounsaturated),
            NutrientHandler(nutrientType: .polyunsaturatedFat, quantityTypeIdentifier: .dietaryFatPolyunsaturated),
            NutrientHandler(nutrientType: .cholesterol, quantityTypeIdentifier: .dietaryCholesterol),
            NutrientHandler(nutrientType: .dietaryFiber, quantityTypeIdentifier: .dietaryFiber),
            NutrientHandler(nutrientType: .sugar, quantityTypeIdentifier: .dietarySugar),
            NutrientHandler(nutrientType: .vitaminA, quantityTypeIdentifier: .dietaryVitaminA),
            NutrientHandler(nutrientType: .vitaminB6, quantityTypeIdentifier: .dietaryVitaminB6),
            NutrientHandler(nutrientType: .vitaminB12, quantityTypeIdentifier: .dietaryVitaminB12),
            NutrientHandler(nutrientType: .vitaminC, quantityTypeIdentifier: .dietaryVitaminC),
            NutrientHandler(nutrientType: .vitaminD, quantityTypeIdentifier: .dietaryVitaminD),
            NutrientHandler(nutrientType: .vitaminE, quantityTypeIdentifier: .dietaryVitaminE),
            NutrientHandler(nutrientType: .vitaminK, quantityTypeIdentifier: .dietaryVitaminK),
            NutrientHandler(nutrientType: .thiamin, quantityTypeIdentifier: .dietaryThiamin),
            NutrientHandler(nutrientType: .riboflavin, quantityTypeIdentifier: .dietaryRiboflavin),
            NutrientHandler(nutrientType: .niacin, quantityTypeIdentifier: .dietaryNiacin),
            NutrientHandler(nutrientType: .folate, quantityTypeIdentifier: .dietaryFolate),
            NutrientHandler(nutrientType: .biotin, quantityTypeIdentifier: .dietaryBiotin),
            NutrientHandler(nutrientType: .pantothenicAcid, quantityTypeIdentifier: .dietaryPantothenicAcid),
            NutrientHandler(nutrientType: .calcium, quantityTypeIdentifier: .dietaryCalcium),
            NutrientHandler(nutrientType: .iron, quantityTypeIdentifier: .dietaryIron),
            NutrientHandler(nutrientType: .magnesium, quantityTypeIdentifier: .dietaryMagnesium),
            NutrientHandler(nutrientType: .manganese, quantityTypeIdentifier: .dietaryManganese),
            NutrientHandler(nutrientType: .phosphorus, quantityTypeIdentifier: .dietaryPhosphorus),
            NutrientHandler(nutrientType: .potassium, quantityTypeIdentifier: .dietaryPotassium),
            NutrientHandler(nutrientType: .selenium, quantityTypeIdentifier: .dietarySelenium),
            NutrientHandler(nutrientType: .sodium, quantityTypeIdentifier: .dietarySodium),
            NutrientHandler(nutrientType: .zinc, quantityTypeIdentifier: .dietaryZinc)
        ]
    }
}

// MARK: - Protocol Compatibility Wrappers

/**
 * Wrapper to bridge instance-based NutrientHandler with static protocol requirements.
 *
 * Since NutrientHandler is parameterized (one instance per nutrient type), we need
 * wrapper structs that conform to the static protocol requirements for registry registration.
 */

// Energy nutrient
struct EnergyNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .energyNutrient, quantityTypeIdentifier: .dietaryEnergyConsumed)

    static var supportedType: HealthDataTypeDto { .energyNutrient }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Caffeine
struct CaffeineNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .caffeine, quantityTypeIdentifier: .dietaryCaffeine)

    static var supportedType: HealthDataTypeDto { .caffeine }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Protein
struct ProteinNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .protein, quantityTypeIdentifier: .dietaryProtein)

    static var supportedType: HealthDataTypeDto { .protein }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Total Carbohydrate
struct TotalCarbohydrateNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .totalCarbohydrate, quantityTypeIdentifier: .dietaryCarbohydrates)

    static var supportedType: HealthDataTypeDto { .totalCarbohydrate }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Total Fat
struct TotalFatNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .totalFat, quantityTypeIdentifier: .dietaryFatTotal)

    static var supportedType: HealthDataTypeDto { .totalFat }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Saturated Fat
struct SaturatedFatNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .saturatedFat, quantityTypeIdentifier: .dietaryFatSaturated)

    static var supportedType: HealthDataTypeDto { .saturatedFat }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Monounsaturated Fat
struct MonounsaturatedFatNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .monounsaturatedFat, quantityTypeIdentifier: .dietaryFatMonounsaturated)

    static var supportedType: HealthDataTypeDto { .monounsaturatedFat }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Polyunsaturated Fat
struct PolyunsaturatedFatNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .polyunsaturatedFat, quantityTypeIdentifier: .dietaryFatPolyunsaturated)

    static var supportedType: HealthDataTypeDto { .polyunsaturatedFat }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Cholesterol
struct CholesterolNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .cholesterol, quantityTypeIdentifier: .dietaryCholesterol)

    static var supportedType: HealthDataTypeDto { .cholesterol }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Dietary Fiber
struct DietaryFiberNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .dietaryFiber, quantityTypeIdentifier: .dietaryFiber)

    static var supportedType: HealthDataTypeDto { .dietaryFiber }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Sugar
struct SugarNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .sugar, quantityTypeIdentifier: .dietarySugar)

    static var supportedType: HealthDataTypeDto { .sugar }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Vitamin A
struct VitaminANutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .vitaminA, quantityTypeIdentifier: .dietaryVitaminA)

    static var supportedType: HealthDataTypeDto { .vitaminA }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Vitamin B6
struct VitaminB6NutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .vitaminB6, quantityTypeIdentifier: .dietaryVitaminB6)

    static var supportedType: HealthDataTypeDto { .vitaminB6 }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Vitamin B12
struct VitaminB12NutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .vitaminB12, quantityTypeIdentifier: .dietaryVitaminB12)

    static var supportedType: HealthDataTypeDto { .vitaminB12 }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Vitamin C
struct VitaminCNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .vitaminC, quantityTypeIdentifier: .dietaryVitaminC)

    static var supportedType: HealthDataTypeDto { .vitaminC }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Vitamin D
struct VitaminDNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .vitaminD, quantityTypeIdentifier: .dietaryVitaminD)

    static var supportedType: HealthDataTypeDto { .vitaminD }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Vitamin E
struct VitaminENutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .vitaminE, quantityTypeIdentifier: .dietaryVitaminE)

    static var supportedType: HealthDataTypeDto { .vitaminE }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Vitamin K
struct VitaminKNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .vitaminK, quantityTypeIdentifier: .dietaryVitaminK)

    static var supportedType: HealthDataTypeDto { .vitaminK }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Thiamin
struct ThiaminNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .thiamin, quantityTypeIdentifier: .dietaryThiamin)

    static var supportedType: HealthDataTypeDto { .thiamin }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Riboflavin
struct RiboflavinNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .riboflavin, quantityTypeIdentifier: .dietaryRiboflavin)

    static var supportedType: HealthDataTypeDto { .riboflavin }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Niacin
struct NiacinNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .niacin, quantityTypeIdentifier: .dietaryNiacin)

    static var supportedType: HealthDataTypeDto { .niacin }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Folate
struct FolateNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .folate, quantityTypeIdentifier: .dietaryFolate)

    static var supportedType: HealthDataTypeDto { .folate }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Biotin
struct BiotinNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .biotin, quantityTypeIdentifier: .dietaryBiotin)

    static var supportedType: HealthDataTypeDto { .biotin }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Pantothenic Acid
struct PantothenicAcidNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .pantothenicAcid, quantityTypeIdentifier: .dietaryPantothenicAcid)

    static var supportedType: HealthDataTypeDto { .pantothenicAcid }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Calcium
struct CalciumNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .calcium, quantityTypeIdentifier: .dietaryCalcium)

    static var supportedType: HealthDataTypeDto { .calcium }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Iron
struct IronNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .iron, quantityTypeIdentifier: .dietaryIron)

    static var supportedType: HealthDataTypeDto { .iron }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Magnesium
struct MagnesiumNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .magnesium, quantityTypeIdentifier: .dietaryMagnesium)

    static var supportedType: HealthDataTypeDto { .magnesium }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Manganese
struct ManganeseNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .manganese, quantityTypeIdentifier: .dietaryManganese)

    static var supportedType: HealthDataTypeDto { .manganese }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Phosphorus
struct PhosphorusNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .phosphorus, quantityTypeIdentifier: .dietaryPhosphorus)

    static var supportedType: HealthDataTypeDto { .phosphorus }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Potassium
struct PotassiumNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .potassium, quantityTypeIdentifier: .dietaryPotassium)

    static var supportedType: HealthDataTypeDto { .potassium }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Selenium
struct SeleniumNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .selenium, quantityTypeIdentifier: .dietarySelenium)

    static var supportedType: HealthDataTypeDto { .selenium }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Sodium
struct SodiumNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .sodium, quantityTypeIdentifier: .dietarySodium)

    static var supportedType: HealthDataTypeDto { .sodium }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}

// Zinc
struct ZincNutrientHandler: HealthKitQuantityHandler {
    private static let handler = NutrientHandler(nutrientType: .zinc, quantityTypeIdentifier: .dietaryZinc)

    static var supportedType: HealthDataTypeDto { .zinc }
    static var category: HealthKitDataCategory { .quantitySample }
    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? { try handler.toDTO(sample) }
    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample { try handler.toHealthKit(dto) }
    static func getSampleType() -> HKSampleType { handler.getSampleType() }
    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 { handler.extractTimestamp(dto) }
    static func supportedAggregations() -> [AggregationMetricDto] { handler.supportedAggregations() }
    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions { handler.toStatisticsOptions(metric) }
}
