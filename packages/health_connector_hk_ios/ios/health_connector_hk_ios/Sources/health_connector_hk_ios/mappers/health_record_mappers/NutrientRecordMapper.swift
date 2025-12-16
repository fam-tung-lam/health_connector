import Foundation
import HealthKit

private extension String {
    static let foodNameKey = "com.phamtunglam.health_connector.food_name"
    static let mealTypeKey = "com.phamtunglam.health_connector.meal_type"
}

extension [String: Any] {
    /// Extracts food name from HealthKit metadata.
    func extractFoodName() -> String? {
        self[.foodNameKey] as? String
    }

    /// Extracts meal type from HealthKit metadata.
    func extractMealType() -> MealTypeDto? {
        guard let mealTypeString = self[.mealTypeKey] as? String else {
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
            metadata[.foodNameKey] = foodName
        }
        if let mealType {
            metadata[.mealTypeKey] = mealType.toString()
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
    /// - Returns: The appropriate nutrient RecordDto, or nil if type mismatch
    func toNutrientDto(for nutrientType: HealthDataTypeDto) -> HealthRecordDto? {
        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let foodName = metadataDict.extractFoodName()
        let mealType = metadataDict.extractMealType()

        let time = startDate.millisecondsSince1970
        let id = uuid.uuidString
        let metadataDto = metadataDict.toMetadataDto(
            source: sourceRevision.source,
            device: device
        )

        switch nutrientType {
        case .energyNutrient:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryEnergyConsumed.rawValue
            else {
                return nil
            }
            return EnergyNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toEnergyDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .caffeine:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryCaffeine.rawValue
            else {
                return nil
            }
            return CaffeineNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .protein:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryProtein.rawValue else {
                return nil
            }
            return ProteinNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .totalCarbohydrate:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryCarbohydrates.rawValue
            else {
                return nil
            }
            return TotalCarbohydrateNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .totalFat:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryFatTotal.rawValue
            else {
                return nil
            }
            return TotalFatNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .saturatedFat:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryFatSaturated.rawValue
            else {
                return nil
            }
            return SaturatedFatNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .monounsaturatedFat:
            guard
                quantityType.identifier
                == HKQuantityTypeIdentifier.dietaryFatMonounsaturated.rawValue
            else {
                return nil
            }
            return MonounsaturatedFatNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .polyunsaturatedFat:
            guard
                quantityType.identifier
                == HKQuantityTypeIdentifier.dietaryFatPolyunsaturated.rawValue
            else {
                return nil
            }
            return PolyunsaturatedFatNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .cholesterol:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryCholesterol.rawValue
            else {
                return nil
            }
            return CholesterolNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .dietaryFiber:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryFiber.rawValue else {
                return nil
            }
            return DietaryFiberNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .sugar:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietarySugar.rawValue else {
                return nil
            }
            return SugarNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .vitaminA:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryVitaminA.rawValue
            else {
                return nil
            }
            return VitaminANutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .vitaminB6:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryVitaminB6.rawValue
            else {
                return nil
            }
            return VitaminB6NutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .vitaminB12:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryVitaminB12.rawValue
            else {
                return nil
            }
            return VitaminB12NutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .vitaminC:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryVitaminC.rawValue
            else {
                return nil
            }
            return VitaminCNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .vitaminD:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryVitaminD.rawValue
            else {
                return nil
            }
            return VitaminDNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .vitaminE:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryVitaminE.rawValue
            else {
                return nil
            }
            return VitaminENutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .vitaminK:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryVitaminK.rawValue
            else {
                return nil
            }
            return VitaminKNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .thiamin:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryThiamin.rawValue else {
                return nil
            }
            return ThiaminNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .riboflavin:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryRiboflavin.rawValue
            else {
                return nil
            }
            return RiboflavinNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .niacin:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryNiacin.rawValue else {
                return nil
            }
            return NiacinNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .folate:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryFolate.rawValue else {
                return nil
            }
            return FolateNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .biotin:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryBiotin.rawValue else {
                return nil
            }
            return BiotinNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .pantothenicAcid:
            guard
                quantityType.identifier == HKQuantityTypeIdentifier.dietaryPantothenicAcid.rawValue
            else {
                return nil
            }
            return PantothenicAcidNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .calcium:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryCalcium.rawValue else {
                return nil
            }
            return CalciumNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .iron:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryIron.rawValue else {
                return nil
            }
            return IronNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .magnesium:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryMagnesium.rawValue
            else {
                return nil
            }
            return MagnesiumNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .manganese:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryManganese.rawValue
            else {
                return nil
            }
            return ManganeseNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .phosphorus:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryPhosphorus.rawValue
            else {
                return nil
            }
            return PhosphorusNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .potassium:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryPotassium.rawValue
            else {
                return nil
            }
            return PotassiumNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .selenium:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietarySelenium.rawValue
            else {
                return nil
            }
            return SeleniumNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .sodium:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietarySodium.rawValue else {
                return nil
            }
            return SodiumNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        case .zinc:
            guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryZinc.rawValue else {
                return nil
            }
            return ZincNutrientRecordDto(
                id: id,
                metadata: metadataDto,
                time: time,
                zoneOffsetSeconds: zoneOffset,
                value: quantity.toMassDto(),
                foodName: foodName,
                mealType: mealType
            )

        default:
            return nil
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
        quantityTypeIdentifier: HKQuantityTypeIdentifier
    ) throws -> HKQuantitySample {
        let quantityType = try HKQuantityType.make(from: quantityTypeIdentifier)

        let quantity: HKQuantity
        let time: Int64
        let zoneOffsetSeconds: Int64?
        let foodName: String?
        let mealType: MealTypeDto?
        let metadata: MetadataDto

        // Extract common fields based on DTO type
        switch self {
        case let dto as EnergyNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as CaffeineNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as ProteinNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as TotalCarbohydrateNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as TotalFatNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as SaturatedFatNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as MonounsaturatedFatNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as PolyunsaturatedFatNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as CholesterolNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as DietaryFiberNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as SugarNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as VitaminANutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as VitaminB6NutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as VitaminB12NutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as VitaminCNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as VitaminDNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as VitaminENutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as VitaminKNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as ThiaminNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as RiboflavinNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as NiacinNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as FolateNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as BiotinNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as PantothenicAcidNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as CalciumNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as IronNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as MagnesiumNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as ManganeseNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as PhosphorusNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as PotassiumNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as SeleniumNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as SodiumNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        case let dto as ZincNutrientRecordDto:
            quantity = dto.value.toHealthKit()
            time = dto.time
            zoneOffsetSeconds = dto.zoneOffsetSeconds
            foodName = dto.foodName
            mealType = dto.mealType
            metadata = dto.metadata

        default:
            throw HealthConnectorError.invalidArgument(
                message: "Expected nutrient DTO for \(nutrientType), got \(type(of: self))"
            )
        }

        let date = Date(millisecondsSince1970: time)
        let timeZone: TimeZone? =
            if let zoneOffsetSeconds {
                TimeZone(secondsFromGMT: Int(zoneOffsetSeconds))
            } else {
                nil
            }

        return HKQuantitySample(
            type: quantityType,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitNutrientMetadata(
                timeZone: timeZone,
                foodName: foodName,
                mealType: mealType
            )
        )
    }
}
