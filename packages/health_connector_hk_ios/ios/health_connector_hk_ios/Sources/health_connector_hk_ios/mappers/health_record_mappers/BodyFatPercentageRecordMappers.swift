import Foundation
import HealthKit

extension BodyFatPercentageRecordDto {
    /*
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     */
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create body fat percentage quantity type"]
            )
        }

        let quantity = percentage.toHealthKit()
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
     * Converts this HealthKit sample to a `BodyFatPercentageRecordDto`.
     */
    func toBodyFatPercentageRecordDto() -> BodyFatPercentageRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bodyFatPercentage.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return BodyFatPercentageRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            percentage: quantity.toPercentageDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
