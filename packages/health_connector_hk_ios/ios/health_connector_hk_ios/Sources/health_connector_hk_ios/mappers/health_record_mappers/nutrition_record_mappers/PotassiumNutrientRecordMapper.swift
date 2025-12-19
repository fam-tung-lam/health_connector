import Foundation
import HealthKit

extension HKQuantitySample {
    /// Converts this HealthKit quantity sample to a PotassiumNutrientRecordDto.
    ///
    /// - Returns: PotassiumNutrientRecordDto
    /// - Throws: `HealthConnectorError.invalidArgument` if quantity type mismatch
    func toPotassiumNutrientDto() throws -> PotassiumNutrientRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryPotassium.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected dietary potassium quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.dietaryPotassium.rawValue,
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

        return PotassiumNutrientRecordDto(
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

extension PotassiumNutrientRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKitQuantitySample() throws -> HKQuantitySample {
        let quantityType = try HKQuantityType.make(from: .dietaryPotassium)
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
