import Foundation
import HealthKit

extension ActiveCaloriesBurnedRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .activeEnergyBurned)

        let quantity = energy.toHealthKit()
        let startDate = Date(millisecondsSince1970: startTime)
        let endDate = Date(millisecondsSince1970: endTime)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: startDate,
            end: endDate,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata(timeZone: TimeZone.current)
        )
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to an `ActiveCaloriesBurnedRecordDto`.
    ///
    /// Returns `nil` if this sample is not an active energy burned sample.
    func toActiveCaloriesBurnedRecordDto() -> ActiveCaloriesBurnedRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.activeEnergyBurned.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return ActiveCaloriesBurnedRecordDto(
            energy: quantity.toEnergyDto(),
            endTime: endDate.millisecondsSince1970,
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            startTime: startDate.millisecondsSince1970,
            zoneOffsetSeconds: zoneOffset
        )
    }
}
