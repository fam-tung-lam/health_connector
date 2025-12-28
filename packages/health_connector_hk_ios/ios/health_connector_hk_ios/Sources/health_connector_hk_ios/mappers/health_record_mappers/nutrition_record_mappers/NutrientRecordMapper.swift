import Foundation
import HealthKit

// MARK: - Custom Metadata Keys

private let nutrientFoodNameMetadataKey =
    "\(hkMetadataKeyPrefix)food_name"
private let nutrientMealTypeMetadataKey =
    "\(hkMetadataKeyPrefix)meal_type"
extension [String: Any] {
    /// Extracts food name from HealthKit metadata.
    func extractFoodName() -> String? {
        self[nutrientFoodNameMetadataKey] as? String
    }

    /// Extracts meal type from HealthKit metadata.
    func extractMealType() -> MealTypeDto? {
        guard let mealTypeString = self[nutrientMealTypeMetadataKey] as? String else {
            return nil
        }
        return MealTypeDto.fromString(mealTypeString)
    }
}

extension MetadataDto {
    /// Converts metadata DTO to HealthKit metadata including nutrient-specific fields.
    func toHealthKitNutrientMetadata(
        timeZone: TimeZone? = nil,
        foodName: String? = nil,
        mealType: MealTypeDto? = nil
    ) -> [String: Any] {
        var metadata = toHealthKitMetadata(timeZone: timeZone)

        // Add nutrient-specific metadata
        if let foodName {
            metadata[nutrientFoodNameMetadataKey] = foodName
        }
        if let mealType {
            metadata[nutrientMealTypeMetadataKey] = mealType.toString()
        }

        return metadata
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
        case .energyNutrient:
            return try toEnergyNutrientDto()
        case .caffeine:
            return try toCaffeineNutrientDto()
        case .protein:
            return try toProteinNutrientDto()
        case .totalCarbohydrate:
            return try toTotalCarbohydrateNutrientDto()
        case .totalFat:
            return try toTotalFatNutrientDto()
        case .saturatedFat:
            return try toSaturatedFatNutrientDto()
        case .monounsaturatedFat:
            return try toMonounsaturatedFatNutrientDto()
        case .polyunsaturatedFat:
            return try toPolyunsaturatedFatNutrientDto()
        case .cholesterol:
            return try toCholesterolNutrientDto()
        case .dietaryFiber:
            return try toDietaryFiberNutrientDto()
        case .sugar:
            return try toSugarNutrientDto()
        case .vitaminA:
            return try toVitaminANutrientDto()
        case .vitaminB6:
            return try toVitaminB6NutrientDto()
        case .vitaminB12:
            return try toVitaminB12NutrientDto()
        case .vitaminC:
            return try toVitaminCNutrientDto()
        case .vitaminD:
            return try toVitaminDNutrientDto()
        case .vitaminE:
            return try toVitaminENutrientDto()
        case .vitaminK:
            return try toVitaminKNutrientDto()
        case .thiamin:
            return try toThiaminNutrientDto()
        case .riboflavin:
            return try toRiboflavinNutrientDto()
        case .niacin:
            return try toNiacinNutrientDto()
        case .folate:
            return try toFolateNutrientDto()
        case .biotin:
            return try toBiotinNutrientDto()
        case .pantothenicAcid:
            return try toPantothenicAcidNutrientDto()
        case .calcium:
            return try toCalciumNutrientDto()
        case .iron:
            return try toIronNutrientDto()
        case .magnesium:
            return try toMagnesiumNutrientDto()
        case .manganese:
            return try toManganeseNutrientDto()
        case .phosphorus:
            return try toPhosphorusNutrientDto()
        case .potassium:
            return try toPotassiumNutrientDto()
        case .selenium:
            return try toSeleniumNutrientDto()
        case .sodium:
            return try toSodiumNutrientDto()
        case .zinc:
            return try toZincNutrientDto()
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
        case let dto as EnergyNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as CaffeineNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as ProteinNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as TotalCarbohydrateNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as TotalFatNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as SaturatedFatNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as MonounsaturatedFatNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as PolyunsaturatedFatNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as CholesterolNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryFiberNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as SugarNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminANutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminB6NutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminB12NutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminCNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminDNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminENutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminKNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as ThiaminNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as RiboflavinNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as NiacinNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as FolateNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as BiotinNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as PantothenicAcidNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as CalciumNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as IronNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as MagnesiumNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as ManganeseNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as PhosphorusNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as PotassiumNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as SeleniumNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as SodiumNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as ZincNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        default:
            throw HealthConnectorError.invalidArgument(
                message: "Expected nutrient DTO for \(nutrientType), got \(type(of: self))"
            )
        }
    }
}
