import Foundation
import HealthKit

extension OxygenSaturationRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .oxygenSaturation) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey: "Failed to create oxygen saturation quantity type",
                ]
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
    /// Converts this HealthKit sample to a `OxygenSaturationRecordDto`.
    func toOxygenSaturationRecordDto() -> OxygenSaturationRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.oxygenSaturation.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return OxygenSaturationRecordDto(
            id: uuid.uuidString,
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            percentage: quantity.toPercentageDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
