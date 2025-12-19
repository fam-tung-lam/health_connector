import Foundation
import HealthKit

extension HKQuantitySample {
    /// Converts this HealthKit quantity sample to a VitaminB6NutrientRecordDto.
    ///
    /// - Returns: VitaminB6NutrientRecordDto
    /// - Throws: `HealthConnectorError.invalidArgument` if quantity type mismatch
    func toVitaminB6NutrientDto() throws -> VitaminB6NutrientRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryVitaminB6.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected dietary vitamin B6 quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.dietaryVitaminB6.rawValue,
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

        return VitaminB6NutrientRecordDto(
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

extension VitaminB6NutrientRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKitQuantitySample() throws -> HKQuantitySample {
        let quantityType = try HKQuantityType.make(from: .dietaryVitaminB6)
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
