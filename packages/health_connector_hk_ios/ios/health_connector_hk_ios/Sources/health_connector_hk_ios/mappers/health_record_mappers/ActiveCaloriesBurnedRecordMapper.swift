import Foundation
import HealthKit

extension ActiveCaloriesBurnedRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create active energy burned quantity type"]
            )
        }

        let quantity = energy.toHealthKit()
        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000.0)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000.0)

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
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
