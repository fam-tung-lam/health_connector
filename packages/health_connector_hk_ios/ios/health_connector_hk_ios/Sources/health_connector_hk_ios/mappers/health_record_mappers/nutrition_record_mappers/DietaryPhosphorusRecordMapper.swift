import Foundation
import HealthKit

/// Extension for mapping `HKQuantitySample` → `DietaryPhosphorusRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit quantity sample to a DietaryPhosphorusRecordDto.
    ///
    /// - Returns: DietaryPhosphorusRecordDto
    /// - Throws: `HealthConnectorError.invalidArgument` if quantity type mismatch
    func toDietaryPhosphorusDto() throws -> DietaryPhosphorusRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryPhosphorus.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected dietary phosphorus quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.dietaryPhosphorus.rawValue,
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

        return DietaryPhosphorusRecordDto(
            id: id,
            metadata: metadataDto,
            time: time,
            zoneOffsetSeconds: zoneOffset,
            grams: quantity.doubleValue(for: HKUnit.gram()),
            foodName: foodName,
            mealType: mealType
        )
    }
}

/// Extension for mapping `DietaryPhosphorusRecordDto` → `HKQuantitySample`.
extension DietaryPhosphorusRecordDto {
    /// Converts this `DietaryPhosphorusRecordDto` to its corresponding `HKQuantitySample`.
    ///
    /// - Returns: The corresponding `HKQuantitySample`
    /// - Throws: `HealthConnectorError` if the quantity type cannot be created
    func toHKQuantitySample() throws -> HKQuantitySample {
        let quantityType = try HKQuantityType.make(from: .dietaryPhosphorus)
        let unit = HKUnit.gram()
        let quantity = HKQuantity(unit: unit, doubleValue: grams)
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
