import Foundation
import HealthKit

// MARK: - Metadata Extraction Extensions

extension MetadataDto {
    /// Converts metadata DTO to HealthKit metadata including nutrient-specific fields.
    ///
    /// Uses the centralized key infrastructure for consistent key naming.
    func toHealthKitNutrientMetadata(
        zoneOffsetSeconds: Int64? = nil,
        foodName: String? = nil,
        mealType: MealTypeDto? = nil
    ) throws -> [String: Any]? {
        var builder = try MetadataBuilder(
            from: self,
            startTimeZoneOffset: zoneOffsetSeconds
        )

        // Add nutrient-specific metadata using centralized keys
        if let foodName {
            builder.set(NutrientFoodNameKey.self, value: foodName)
        }
        if let mealType {
            builder.set(NutrientMealTypeKey.self, value: mealType)
        }

        return builder.metadataDict
    }
}

// MARK: - Generic Nutrient Mapper Functions

extension HKQuantitySample {
    /// Converts this HealthKit quantity sample to a nutrient DTO.
    ///
    /// This is a generic mapper that delegates to specific nutrient DTOs based on the
    /// nutrient type provided.
    ///
    /// - Parameter nutrientType: The type of nutrient to convert to
    /// - Returns: The appropriate nutrient RecordDto
    /// - Throws: `HealthConnectorError.invalidArgument` if type mismatch
    func toNutrientDto(for nutrientType: HealthDataTypeDto) throws -> HealthRecordDto {
        switch nutrientType {
        case .dietaryEnergyConsumed:
            return try toDietaryEnergyConsumedDto()
        case .caffeine:
            return try toDietaryCaffeineDto()
        case .protein:
            return try toDietaryProteinDto()
        case .totalCarbohydrate:
            return try toDietaryTotalCarbohydrateDto()
        case .totalFat:
            return try toDietaryTotalFatDto()
        case .saturatedFat:
            return try toDietarySaturatedFatDto()
        case .monounsaturatedFat:
            return try toDietaryMonounsaturatedFatDto()
        case .polyunsaturatedFat:
            return try toDietaryPolyunsaturatedFatDto()
        case .cholesterol:
            return try toDietaryCholesterolDto()
        case .dietaryFiber:
            return try toDietaryFiberDto()
        case .sugar:
            return try toDietarySugarDto()
        case .vitaminA:
            return try toDietaryVitaminADto()
        case .vitaminB6:
            return try toDietaryVitaminB6Dto()
        case .vitaminB12:
            return try toDietaryVitaminB12Dto()
        case .vitaminC:
            return try toDietaryVitaminCDto()
        case .vitaminD:
            return try toDietaryVitaminDDto()
        case .vitaminE:
            return try toDietaryVitaminEDto()
        case .vitaminK:
            return try toDietaryVitaminKDto()
        case .thiamin:
            return try toDietaryThiaminDto()
        case .riboflavin:
            return try toDietaryRiboflavinDto()
        case .niacin:
            return try toDietaryNiacinDto()
        case .folate:
            return try toDietaryFolateDto()
        case .biotin:
            return try toDietaryBiotinDto()
        case .pantothenicAcid:
            return try toDietaryPantothenicAcidDto()
        case .calcium:
            return try toDietaryCalciumDto()
        case .iron:
            return try toDietaryIronDto()
        case .magnesium:
            return try toDietaryMagnesiumDto()
        case .manganese:
            return try toDietaryManganeseDto()
        case .phosphorus:
            return try toDietaryPhosphorusDto()
        case .potassium:
            return try toDietaryPotassiumDto()
        case .selenium:
            return try toDietarySeleniumDto()
        case .sodium:
            return try toDietarySodiumDto()
        case .zinc:
            return try toDietaryZincDto()
        default:
            throw HealthConnectorError.invalidArgument(
                message: "Unsupported nutrient type for HKQuantitySample",
                context: [
                    "nutrientType": nutrientType.rawValue,
                    "quantityType": quantityType.identifier,
                ]
            )
        }
    }
}

// MARK: - DTO to HealthKit Conversion

extension HealthRecordDto {
    /// Converts nutrient DTO to HealthKit quantity sample.
    ///
    /// - Parameters:
    ///   - nutrientType: The type of nutrient being converted
    ///   - quantityTypeIdentifier: The HealthKit quantity type identifier
    /// - Returns: HKQuantitySample for the nutrient
    /// - Throws: Error if conversion fails or DTO type is wrong
    func toHealthKitNutrientSample(
        for nutrientType: HealthDataTypeDto,
        quantityTypeIdentifier _: HKQuantityTypeIdentifier
    ) throws -> HKQuantitySample {
        switch self {
        case let dto as DietaryEnergyConsumedRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryCaffeineRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryProteinRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryTotalCarbohydrateRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryTotalFatRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietarySaturatedFatRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryMonounsaturatedFatRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryPolyunsaturatedFatRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryCholesterolRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryFiberRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietarySugarRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminARecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminB6RecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminB12RecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminCRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminDRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminERecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminKRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryThiaminRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryRiboflavinRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryNiacinRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryFolateRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryBiotinRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryPantothenicAcidRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryCalciumRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryIronRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryMagnesiumRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryManganeseRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryPhosphorusRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryPotassiumRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietarySeleniumRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietarySodiumRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryZincRecordDto:
            return try dto.toHealthKitQuantitySample()
        default:
            throw HealthConnectorError.invalidArgument(
                message: "Expected nutrient DTO for \(nutrientType), got \(type(of: self))"
            )
        }
    }
}
