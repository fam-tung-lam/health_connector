import Foundation
import HealthKit

extension HKQuantitySample {
    /// Converts this HealthKit quantity sample to a PhosphorusNutrientRecordDto.
    ///
    /// - Returns: PhosphorusNutrientRecordDto
    /// - Throws: `HealthConnectorError.invalidArgument` if quantity type mismatch
    func toPhosphorusNutrientDto() throws -> PhosphorusNutrientRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryPhosphorus.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected dietary phosphorus quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.dietaryPhosphorus.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

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

        return PhosphorusNutrientRecordDto(
            id: id,
            metadata: metadataDto,
            time: time,
            zoneOffsetSeconds: zoneOffset,
            value: quantity.toMassDto(),
            foodName: foodName,
            mealType: mealType
        )
    }
}

extension PhosphorusNutrientRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKitQuantitySample() throws -> HKQuantitySample {
        let quantityType = try HKQuantityType.make(from: .dietaryPhosphorus)
        let quantity = value.toHealthKit()
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
            end: date,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitNutrientMetadata(
                timeZone: timeZone,
                foodName: foodName,
                mealType: mealType
            )
        )
    }
}
