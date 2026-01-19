import Foundation
import HealthKit

/// Extension for mapping `HKQuantitySample` → `DietaryEnergyConsumedRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit quantity sample to an DietaryEnergyConsumedRecordDto.
    ///
    /// - Returns: DietaryEnergyConsumedRecordDto
    /// - Throws: `HealthConnectorError.invalidArgument` if quantity type mismatch
    func toDietaryEnergyConsumedDto() throws -> DietaryEnergyConsumedRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryEnergyConsumed.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected dietary energy consumed quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.dietaryEnergyConsumed.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let foodName = NutrientFoodNameKey.read(from: builder.metadataDict)
        let mealType = NutrientMealTypeKey.read(from: builder.metadataDict)

        let time = startDate.millisecondsSince1970
        let id = uuid.uuidString
        let metadataDto = try builder.toMetadataDto()

        return DietaryEnergyConsumedRecordDto(
            id: id,
            metadata: metadataDto,
            time: time,
            zoneOffsetSeconds: zoneOffset,
            kilocalories: quantity.doubleValue(for: HKUnit.kilocalorie()),
            foodName: foodName,
            mealType: mealType
        )
    }
}

/// Extension for mapping `DietaryEnergyConsumedRecordDto` → `HKQuantitySample`.
extension DietaryEnergyConsumedRecordDto {
    /// Converts this `DietaryEnergyConsumedRecordDto` to its corresponding `HKQuantitySample`.
    ///
    /// - Returns: The corresponding `HKQuantitySample`
    /// - Throws: `HealthConnectorError` if the quantity type cannot be created
    func toHKQuantitySample() throws -> HKQuantitySample {
        let quantityType = try HKQuantityType.make(from: .dietaryEnergyConsumed)
        let unit = HKUnit.kilocalorie()
        let quantity = HKQuantity(unit: unit, doubleValue: kilocalories)
        let date = Date(millisecondsSince1970: time)

        // Create builder with timezone offset
        var builder = try MetadataBuilder(
            from: metadata,
            startTimeZoneOffset: zoneOffsetSeconds
        )

        // Add nutrient-specific metadata
        if let foodName {
            builder.set(NutrientFoodNameKey.self, value: foodName)
        }
        if let mealType {
            builder.set(NutrientMealTypeKey.self, value: mealType)
        }

        return HKQuantitySample(
            type: quantityType,
            quantity: quantity,
            start: date,
            end: date,
            device: builder.healthDevice,
            metadata: builder.metadataDict
        )
    }
}
