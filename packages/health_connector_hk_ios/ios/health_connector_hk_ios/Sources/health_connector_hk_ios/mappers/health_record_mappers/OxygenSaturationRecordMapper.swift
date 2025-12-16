import Foundation
import HealthKit

extension OxygenSaturationRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .oxygenSaturation)

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
    /// Converts this HealthKit sample to a `OxygenSaturationRecordDto`.
    func toOxygenSaturationRecordDto() -> OxygenSaturationRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.oxygenSaturation.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return OxygenSaturationRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            percentage: quantity.toPercentageDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
