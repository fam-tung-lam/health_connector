import Foundation
import HealthKit

extension BodyFatPercentageRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .bodyFatPercentage)

        let quantity = percentage.toHealthKit()
        let date = Date(millisecondsSince1970: time)

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
    /// Converts this HealthKit sample to a `BodyFatPercentageRecordDto`.
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
            time: startDate.millisecondsSince1970,
            percentage: quantity.toPercentageDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
