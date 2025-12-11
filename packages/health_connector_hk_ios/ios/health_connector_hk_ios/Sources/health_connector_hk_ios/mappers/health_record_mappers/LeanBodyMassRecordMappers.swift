import Foundation
import HealthKit

extension LeanBodyMassRecordDto {
    /*
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     */
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .leanBodyMass) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create lean body mass quantity type"]
            )
        }

        let quantity = mass.toHealthKit()
        let date = Date(timeIntervalSince1970: TimeInterval(time) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}

extension HKQuantitySample {
    /*
     * Converts this HealthKit sample to a `LeanBodyMassRecordDto`.
     */
    func toLeanBodyMassRecordDto() -> LeanBodyMassRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.leanBodyMass.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return LeanBodyMassRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            mass: quantity.toMassDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
